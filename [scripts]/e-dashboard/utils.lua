--[[
    Resource: e-auth
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

sx,sy = guiGetScreenSize()
zoom = exports['e-gui']:getZoom()

main = {}

function main:init()
    self.textures = {}
    self.fonts = {}
    self.pages = {}
    self.clck = function (btn,state) main:click(btn,state) end
    self.rnd = function () main:render() end
    self.toggle = false
    self.animation = false
    self.getPages = function () main:pages() end
    self.page = false
    self.alpha = {
        [1] = 0,
        [2] = 0
    }
    self.loaded = false

    self.actuallTask = {
        title = 'Przejdź 2km pieszo',
        progressText = '1.3/2km',
        state = 'W TRAKCIE'
    }
    self.tasks = {
        {
            texture = 'task_green',
            description = 'Zwyzywaj zuzie borsuka'
        },
        {
            texture = 'task_red',
            description = 'Rozjeb pseudola'
        },
        {
            texture = 'task_orange',
            description = 'Zwyzywaj borsuka'
        },
        {
            texture = 'task_red',
            description = 'Napisz "rilm to pseudol a\ncrosroad to gej"'
        },
        {
            texture = 'task_green',
            description = 'Borsuk to zjeb'
        },
        {
            texture = 'task_red',
            description = 'Napisz "SpiceRPG" to syf'
        },
        {
            texture = 'task_red',
            description = 'Napisz "DreamRPG" to syf'
        },
    }

    addEvent('fetchPlayerData',true)
    addEventHandler('fetchPlayerData',root,function (data)
        self.loaded = true
        self.plrData = data
    end)

    self.changePage = function (c)
        self.animation = true
        animate(self.y,self.pages[c].y,'InOutQuad', 600,function (c)
            self.y = c
        end)
        animate(255,0,'InOutQuad', 300,function (c)
            self.alpha[2] = c
        end,function ()
            self.pages[self.page].exit(self)
            self.page = c
            self.pages[self.page].enter(self)
            animate(0,255,'InOutQuad', 300,function (c)
                self.alpha[2] = c
            end,function ()
                self.animation = false
            end)
        end)
    end

    bindKey('f5','down',function ()
        if (self.animation) then return end
        if (self.toggle) then
            self.animation = true
            animate(255,0,'InOutQuad', 300,function (c)
                self.alpha[1] = c
                self.alpha[2] = c
            end,function ()
                self.animation = false
                self.toggle = false
                showCursor(false)
                removeEventHandler('onClientRender',root,self.rnd)
                removeEventHandler('onClientClick',root,self.clck)
                for i,v in pairs(self.textures) do
                    if (isElement(v)) then
                        destroyElement(v)
                    end
                end
                for i,v in pairs(self.fonts) do
                    if (isElement(v)) then
                        destroyElement(v)
                    end
                end
            end)
        else
            self.loaded = false
            triggerServerEvent('fetchPlayerData',localPlayer,localPlayer)
            self.pages = main:getPages()
            self.animation = true
            animate(0,255,'InOutQuad', 300,function (c)
                self.alpha[1] = c
                self.alpha[2] = c
            end,function ()
                self.animation = false
            end)
            self.page = 1
            self.pages[self.page].enter()
            self.y = self.pages[self.page].y
            local c = {
                ['bg'] = true,
                ['mask'] = true,
                ['lvl_bar'] = true,
                ['circle_level'] = true,
                ['lvl_bar_full'] = true,
                ['custom_avatar'] = true,
                ['page_bg'] = true,
                ['menu_bg'] = true,
                ['selected_page'] = true,
                ['main'] = true,
                ['task'] = true,
                ['daily'] = true,
                ['punish'] = true,
                ['settings'] = true,
                ['car'] = true,
                ['user_info_bg'] = true,
                ['daily_task_bg'] = true,
                ['money_bg'] = true,
                ['task_green'] = true,
                ['task_red'] = true,
                ['task_orange'] = true,
                ['task_icon'] = true
            }
            local c2 = {
                [1] = { name = 'medium', size = 18/zoom },
                [2] = { name = 'medium', size = 14/zoom },
                [3] = { name = 'bold', size = 14/zoom },
                [4] = { name = 'light', size = 15/zoom },
                [5] = { name = 'medium', size = 15/zoom },
                [6] = { name = 'light', size = 17/zoom },
                [7] = { name = 'bold', size = 13/zoom },
            }
            for i,v in pairs(c) do
                self.textures[i] = dxCreateTexture('data/images/'..i..'.png')
            end
            for i,v in pairs(c2) do
                self.fonts[i] = exports['e-gui']:getFont(v.name,v.size)
            end
            self.toggle = true
            showCursor(true)
            addEventHandler('onClientRender',root,self.rnd)
            addEventHandler('onClientClick',root,self.clck)
        end
    end)
end

main:init()

local anims, builtins = {}, {"Linear", "InQuad", "OutQuad", "InOutQuad", "OutInQuad", "InElastic", "OutElastic", "InOutElastic", "OutInElastic", "InBack", "OutBack", "InOutBack", "OutInBack", "InBounce", "OutBounce", "InOutBounce", "OutInBounce", "SineCurve", "CosineCurve"}

function table.find(t, v)
	for k, a in ipairs(t) do
		if a == v then
			return k
		end
	end
	return false
end

function animate(f, t, easing, duration, onChange, onEnd)
	assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
	assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
	assert(type(easing) == "string" or (type(easing) == "number" and (easing >= 1 or easing <= #builtins)), "Bad argument @ 'animate' [Invalid easing at argument 3]")
	assert(type(duration) == "number", "Bad argument @ 'animate' [expected number at argument 4, got "..type(duration).."]")
	assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
	table.insert(anims, {from = f, to = t, easing = table.find(builtins, easing) and easing or builtins[easing], duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})
	return #anims
end

function destroyAnimation(a)
	if anims[a] then
		table.remove(anims, a)
	end
end

addEventHandler("onClientRender", root, function( )
	local now = getTickCount( )
	for k,v in ipairs(anims) do
		v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
		if now >= v.start+v.duration then
			if type(v.onEnd) == "function" then
				v.onEnd( )
			end
			table.remove(anims, k)
		end
	end
end)

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function addCommas(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end