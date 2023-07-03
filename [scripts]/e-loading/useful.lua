sx, sy = guiGetScreenSize()
zoom = (sx < 2048) and math.min(2.2, 2048/sx) or 1

function test()
    return [[local __internal = {
        __internal = {}
    }
    setmetatable(__internal, {
        __index = function(t, key)
            if t.__internal[key] then
                local v = t.__internal[key]
                local progress = math.max(math.min((getTickCount() - v.startTime) / (v.stopTime - v.startTime), 1), 0)
                -- return v.start + (v.stop - v.start) * progress
                return interpolateBetween(v.start, 0, 0, v.stop, 0, 0, progress, v.easing)
            else return 0 end
        end,
        __newindex = function(t, key, value)
            local time = value.time or value[3] or (t.__internal[key] and (t.__internal[key].stopTime - t.__internal[key].startTime)) or 0
            t.__internal[key] = {
                start = value.start or value[1] or (t.__internal[key] and t[key]) or 0,
                stop = value.stop or value[2] or (t.__internal[key] and t.__internal[key].stop) or 0,
                startTime = getTickCount(),
                stopTime = getTickCount() + time,
                easing = value.easing or value[4] or (t.__internal[key] and t.__internal[key].easing) or 'Linear',
            }
        end
    })
    
    return __internal;]]
end

a = loadstring(test())()
fonts = {
    figmaFonts = {},
}
textures = {}

function unloadTextures()
    for k,v in pairs(textures) do
        if v and isElement(v) then destroyElement(v) end
    end
    textures = {}
end

function loadTextures(array)
    unloadTextures()
    for _,v in pairs(array) do
        local texture = dxCreateTexture(v[2], 'argb', true, 'clamp')
        local width, height = dxGetMaterialSize(texture)
        textures[v[1]] = {
            texture = texture,
            width = width,
            height = height,
        }
    end
end

function loadFonts(array)
    unloadFonts()
    for _,v in pairs(array) do
        fonts[v[1]] = dxCreateFont(v[2], v[3], v[4], 'proof')
    end
end

function getFigmaFont(font, size)
    local figmaFonts = fonts.figmaFonts
    if not figmaFonts[font..size] then
        figmaFonts[font..size] = exports['figma']:getFont(font, size)
    end

    return figmaFonts[font..size]
end

function wordWrap(text, maxwidth, scale, font, colorcoded)
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