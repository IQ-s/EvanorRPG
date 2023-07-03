--[[
    Resource: e-jobs
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
    self.renderMain = function () main:renderGUI() end
    self.clickMain = function (btn,state) main:click(btn,state) end
    self.texturesToLoad = {
        ['bg'] = true,
        ['exit'] = true,
        ['option_bg'] = true,
        ['info'] = true,
        ['upgrades'] = true,
        ['stats'] = true,
        ['option_bg_hovered'] = true,
        ['button_start'] = true,
        ['upgrade_button'] = true,
        ['wykres_bg'] = true
    }
    self.fontsToLoad = {
        [1] = { name = 'bold', size = 15/zoom },
        [2] = { name = 'medium', size = 15/zoom },
        [3] = { name = 'medium', size = 14/zoom },
        [4] = { name = 'medium', size = 12/zoom }
    }
    self.alpha = {
        [1] = 0,
        [2] = 0
    }
    self.wrap = function (text, maxwidth, scale, font, colorcoded)
        local lines = {}
        local words = split(text, " ") -- this unfortunately will collapse 2+ spaces in a row into a single space
        local line = 1 -- begin with 1st line
        local word = 1 -- begin on 1st word
        local endlinecolor
        while (words[word]) do -- while there are still words to read
            repeat
                if colorcoded and (not lines[line]) and endlinecolor and (not string.find(words[word], "^#%x%x%x%x%x%x")) then -- if on a new line, and endline color is set and the upcoming word isn't beginning with a colorcode
                    lines[line] = endlinecolor -- define this line as beginning with the color code
                end
                lines[line] = lines[line] or "" -- define the line if it doesnt exist
    
                if colorcoded then
                    local rw = string.reverse(words[word]) -- reverse the string
                    local x, y = string.find(rw, "%x%x%x%x%x%x#") -- and search for the first (last) occurance of a color code
                    if x and y then
                        endlinecolor = string.reverse(string.sub(rw, x, y)) -- stores it for the beginning of the next line
                    end
                end
          
                lines[line] = lines[line]..words[word] -- append a new word to the this line
                lines[line] = lines[line] .. " " -- append space to the line
    
                word = word + 1 -- moves onto the next word (in preparation for checking whether to start a new line (that is, if next word won't fit)
            until ((not words[word]) or dxGetTextWidth(lines[line].." "..words[word], scale, font, colorcoded) > maxwidth) -- jumps back to 'repeat' as soon as the code is out of words, or with a new word, it would overflow the maxwidth
        
            lines[line] = string.sub(lines[line], 1, -2) -- removes the final space from this line
            if colorcoded then
                lines[line] = string.gsub(lines[line], "#%x%x%x%x%x%x$", "") -- removes trailing colorcodes
            end
            line = line + 1 -- moves onto the next line
        end -- jumps back to 'while' the a next word exists
        return lines
    end
    self.jobs = {}
    self.job = false
    self.toggle = false
    self.animation = false

    self.createGUI = function (data)
        if self.animation or self.toggle then return end
        for i,v in pairs(self.texturesToLoad) do
            self.textures[i] = dxCreateTexture('data/images/'..i..'.png','argb',false,'clamp')
        end

        for i,v in pairs(self.fontsToLoad) do
            self.fonts[i] = exports['e-gui']:getFont(v.name,v.size)
        end
        self.jobs = {}
        self.jobs = {
            [1] = {
                name = 'Sweepery',
                desc = 'Czyszczenie ulic Sweeperem w San Andreas',
                description = self.wrap('Praca polega na czyszczeniu ulic w stanie San Andreas pojazdem Sweeper. Za każdy zebrany śmieć otrzymujesz wartość kilogramów Po uzupełnieniu całego zbiornika musisz go opróżnić aby dostać wynagrodzenie.',500/zoom,1,self.fonts[3]),
                requirements = false,
                upgrades = {
                    {
                        name = self.wrap('Obrotny - lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsum lorem.',350/zoom,1,self.fonts[3])
                    },
                    {
                        name = self.wrap('Większy kosz - lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsum lorem.',350/zoom,1,self.fonts[3])
                    },
                    {
                        name = self.wrap('Napiwek - lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsum lorem.',350/zoom,1,self.fonts[3])
                    }
                }
            }
        }
        self.pages = pages
        self.y = sy/2-214/2/zoom
        self.job = data.job
        self.page = 1

        addEventHandler('onClientRender',root,self.renderMain)
        addEventHandler('onClientClick',root,self.clickMain)
        self.animation = true
        animate(0,255,'Linear',700,function (c)
            self.alpha[1] = c
            self.alpha[2] = c
        end,function ()
            self.animation = false
        end)
    end
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

