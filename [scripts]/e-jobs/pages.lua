--[[
    Resource: e-jobs
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

pages = {
    {
        name = 'Opis pracy',
        icon = 'info',
        y = sy/2-214/2/zoom,
        enter = function ()
        end,
        exit = function ()
        end,
        render = function (self)
            local offset = 0
            for i=1,#self.jobs[self.job].description do
                offset = offset + dxGetFontHeight(1,self.fonts[3])
                dxDrawText(self.jobs[self.job].description[i],sx/2-245/zoom + 20/zoom,sy/2-214/2/zoom + 7/zoom + offset, nil, nil, tocolor(189,189,189,self.alpha[2]),1,self.fonts[3],'left','center')
            end
            dxDrawText('Wymagania', sx/2-245/zoom + 20/zoom,sy/2-214/2/zoom + 5/zoom + offset + 30/zoom, nil, nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'left','center')
            if (not self.jobs[self.job].requirements) then
                dxDrawText('Brak wymagań - praca startowa',sx/2-245/zoom + 20/zoom,sy/2-214/2/zoom + 5/zoom + offset + 30/zoom + dxGetFontHeight(1,self.fonts[2]), nil, nil, tocolor(189,189,189,self.alpha[2]),1,self.fonts[3],'left','center')
            end
        end
    },
    {
        name = 'Ulepszenia',
        icon = 'upgrades',
        y = sy/2-214/2/zoom + 55/zoom,
        enter = function ()
        end,
        exit = function ()
        end,
        render = function (self)
            local offset = 0
            for i,v in pairs(self.jobs[self.job].upgrades) do
                offset = offset + 80/zoom/1.5
                dxDrawImage(sx/2+150/zoom,sy/2-127/zoom+offset,126/zoom,24/zoom,self.textures['upgrade_button'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2+150/zoom,sy/2-127/zoom+offset,126/zoom,24/zoom) and 255 or 150) or self.alpha[2]*0.6)))
                dxDrawText('Zakup ulepszenie',sx/2+150/zoom + 126/2/zoom,sy/2-127/zoom+offset + 24/2/zoom,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2+150/zoom,sy/2-127/zoom+offset,126/zoom,24/zoom) and 255 or 150) or self.alpha[2]*0.6)),1,self.fonts[4],'center','center')
                for k=1,#v.name do
                    dxDrawText(v.name[k],sx/2-245/zoom + 20/zoom,sy/2-250/2/zoom + offset + (k-1) * dxGetFontHeight(1,self.fonts[3]),nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[3],'left','center')
                end
            end
        end
    },
    {
        name = 'Statystyki pracy',
        icon = 'stats',
        y = sy/2-214/2/zoom + 55/zoom + 55/zoom,
        enter = function (self)
            local earnings = {3281, 2340, 3213, 4521, 2133, 1532, 3278}
            local workers = {32, 14, 23, 13, 23, 34, 43}
            local topList = {
                players = {'borsuk', 'zexty', 'IQ_', 'zevy', 'revenom', 'Indo'},
                data = {142, 89, 65, 23, 13, 6}
            }
            local data = {
                x = sx/2-245/zoom + 20/zoom,
                y = sy/2-40/zoom,
                w = 428/zoom,
                h = 98/zoom,
                rtw = 428,
                rth = 98,
                max = math.floor(math.max(unpack(earnings))*1.5),
                tipFormat = '#38AF59$#FFFFFF%d',
                data = earnings,
                labels = {
                    horizontalPosition = 'left',
                    verticalPosition = 'bottom',
                    horizontal = 'Zarobki ostatniego tygodnia',
                    vertical = nil
                },
                radius = 10/zoom,
                blur = false,
                type = 'line',
                background = tocolor(0,0,0,0),
                color = tocolor(56,175,89,200),
                bottomColor = tocolor(56,175,89,0),
                line = tocolor(56,175,89),
                point = tocolor(56,175,89,200),
                text = 0x88FFFFFF,
                pointSize = 10/zoom,
                min = 0,
                width = 5,
                round = 10,
                marginHorizontal = 5/zoom,
                marginVertical = 13/zoom,
                tipMargin = 15/zoom,
                font = exports['e-gui']:getFont('medium', 12/zoom),
            }
            chart = exports['e-charts']:createChart(data)
            exports['e-charts']:interpolateChart(chart, 0,255,300, 'OutQuad')
        end,
        exit = function ()
            exports['e-charts']:interpolateChart(chart, 255,0,300, 'OutQuad')
            setTimer(function ()
                if (isElement(chart)) then
                    destroyElement(chart)
                end
            end,300,1)
        end,
        render = function (self)
            dxDrawText('Ilość zarobionych pieniędzy',sx/2-245/zoom + 20/zoom,sy/2-214/2/zoom + 30/zoom,nil,nil,tocolor(230,230,230,self.alpha[2]),1,self.fonts[3],'left','center')
            dxDrawText('764,234$',sx/2-245/zoom + 20/zoom + dxGetTextWidth('Ilość zarobionych pieniędzy',1,self.fonts[3]) + 140/zoom,sy/2-214/2/zoom + 30/zoom,nil,nil,tocolor(189,189,231890,self.alpha[2]),1,self.fonts[3],'right','center')
            dxDrawText('Ilość zdobytego doświadczenia',sx/2-245/zoom + 20/zoom,sy/2-214/2/zoom + 30/zoom + dxGetFontHeight(1,self.fonts[3]),nil,nil,tocolor(230,230,230,self.alpha[2]),1,self.fonts[3],'left','center')
            dxDrawText('1,250 xp',sx/2-245/zoom + 20/zoom + dxGetTextWidth('Ilość zarobionych pieniędzy',1,self.fonts[3]) + 140/zoom,sy/2-214/2/zoom + 30/zoom + dxGetFontHeight(1,self.fonts[3]),nil,nil,tocolor(189,189,231890,self.alpha[2]),1,self.fonts[3],'right','center')
            -- dxDrawText('Ilość zebranych śmieci',sx/2-245/zoom + 20/zoom,sy/2-214/2/zoom + 30/zoom + dxGetFontHeight(1,self.fonts[3]) + dxGetFontHeight(1,self.fonts[3]),nil,nil,tocolor(230,230,230,self.alpha[2]),1,self.fonts[3],'left','center')
            -- dxDrawText('1254',sx/2-245/zoom + 20/zoom + dxGetTextWidth('Ilość zarobionych pieniędzy',1,self.fonts[3]) + 140/zoom,sy/2-214/2/zoom + 30/zoom + dxGetFontHeight(1,self.fonts[3]) + dxGetFontHeight(1,self.fonts[3]),nil,nil,tocolor(189,189,231890,self.alpha[2]),1,self.fonts[3],'right','center')
            -- dxDrawText('Ilość przepracowanych godzin',sx/2-245/zoom + 20/zoom,sy/2-214/2/zoom + 30/zoom + dxGetFontHeight(1,self.fonts[3]) + dxGetFontHeight(1,self.fonts[3]) + dxGetFontHeight(1,self.fonts[3]),nil,nil,tocolor(230,230,230,self.alpha[2]),1,self.fonts[3],'left','center')
            -- dxDrawText('35 h',sx/2-245/zoom + 20/zoom + dxGetTextWidth('Ilość zarobionych pieniędzy',1,self.fonts[3]) + 140/zoom,sy/2-214/2/zoom + 30/zoom + dxGetFontHeight(1,self.fonts[3]) + dxGetFontHeight(1,self.fonts[3]) + dxGetFontHeight(1,self.fonts[3]),nil,nil,tocolor(189,189,231890,self.alpha[2]),1,self.fonts[3],'right','center')
            dxDrawImage(sx/2-245/zoom + 20/zoom,sy/2-40/zoom,428/zoom,98/zoom,self.textures['wykres_bg'],0,0,0,tocolor(255,255,255,self.alpha[2]))
        end
    }
}