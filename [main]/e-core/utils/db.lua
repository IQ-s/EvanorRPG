--[[
    Resource: e-core
    Type: Serverside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

local mysqlHandler = nil
local tablePrefix = ""
local mysqlData = {
  login = 'db_94750',
  host = 'sql.18.svpj.link',
  password = 'Gi777CWeIgu3',
  database = 'db_94750'
}

addEvent("onDatabaseConnected", false)

local function mysql_connect( )
  mysqlHandler = dbConnect( "mysql", "dbname=" .. mysqlData.database .. ";host=" .. mysqlData.host .. ";charset=utf8", mysqlData.login, mysqlData.password, "share=1" )
  if mysqlHandler then
    outputDebugString( "[e-core] Successfully connect to database" )
    triggerEvent("onDatabaseConnected", root)
    query( "SET NAMES utf8;" )
    setTimer(query,1000*60*2,0,'SET NAMES utf8;') 
  else
    outputDebugString( "[e-core] Error to connect to database" )
    setTimer( mysql_connect, 10000, 1 )
    return false
  end
  return true
end

function getTablePrefix()
  return tablePrefix
end

addEventHandler( "onResourceStart", resourceRoot, function( )
  tablePrefix = get("tablePrefix")
  mysqlHandler = nil
  mysql_connect( )
end )

function query( ... )
  if not isElement( mysqlHandler ) then
    mysql_connect( ) 
    return
  end

  local safeString=dbPrepareString( mysqlHandler, ... )
	if safeString then
    local query = dbQuery( mysqlHandler, safeString )
    local result, rows, last_insert_id = dbPoll( query, -1 )
    if not result then 
      outputDebugString( "[e-core] skrypt: "..getResourceName(sourceResource)..", blad w zapytaniu: ".. select( 1, ... ), 1 )
      return false
    end 
    return result, last_insert_id, rows
  else 
		return false
	end
	return false
end

function queryTable(sql, table, ...)
  return query(string.format(sql, getTablePrefix()..table),...)
end

function getHandler( )
  if not isElement( mysqlHandler ) then
    mysql_connect( ) 
  end
  
  return mysqlHandler
end

function queryFree( ... )
  if not isElement( mysqlHandler ) then
    mysql_connect( ) 
    return
  end
  
  local safeString = dbPrepareString( mysqlHandler, ... )
  if safeString then
    local query = dbExec( mysqlHandler, safeString )
    return query
	else 
		return false
	end
	return false
end

function queryTableFree(sql, table, ...)
  return queryFree(string.format(sql, getTablePrefix()..table),...)
end


function queryAsync( trigger, args, ... )
  if not isElement( mysqlHandler ) then
    mysql_connect( )
    return
  end

  local safeString = dbPrepareString( mysqlHandler, ... )
	if safeString then
		local function callback( query, ...)
      local args = { ... }
      local triggerName = args[1] 
      table.remove( args, 1 )
      
      local result = dbPoll( query, 0 )
      triggerEvent( triggerName, root, result, unpack( args ) )     
    end
    dbQuery( callback, { trigger, unpack( args ) }, mysqlHandler, safeString )
  end
  return true          
end
