function main:getPages()
    return {
        {
            name = 'Strona główna',
            enter = function ()
            end,
            exit = function ()
            end,
            render = function ()
                dxDrawImage(sx/2 + -149/zoom, sy/2 + -224/zoom, 597/zoom, 242/zoom, self.textures['user_info_bg'], 0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText('Informacje o koncie', sx/2 + -105/zoom, sy/2 + -215/zoom, (sx/2 + -110/zoom) + (152/zoom), (sy/2 + -213/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawText('Nick z serwera', sx/2 + -92/zoom, sy/2 + -165/zoom, (sx/2 + -92/zoom) + (97/zoom), (sy/2 + -165/zoom) + (18/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText('Konto premium', sx/2 + -92/zoom, sy/2 + -135/zoom, (sx/2 + -92/zoom) + (103/zoom), (sy/2 + -135/zoom) + (18/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText('Ilość przegranych godzin na serwerze', sx/2 + -92/zoom, sy/2 + -105/zoom, (sx/2 + -92/zoom) + (244/zoom), (sy/2 + -105/zoom) + (18/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText('Data rejestracji konta', sx/2 + -92/zoom, sy/2 + -75/zoom, (sx/2 + -92/zoom) + (142/zoom), (sy/2 + -75/zoom) + (18/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText('Data ostatniego logowania', sx/2 + -92/zoom, sy/2 + -45/zoom, (sx/2 + -92/zoom) + (177/zoom), (sy/2 + -45/zoom) + (18/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText('Służby porządkowe', sx/2 + -92/zoom, sy/2 + -15/zoom, (sx/2 + -92/zoom) + (128/zoom), (sy/2 + -15/zoom) + (18/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText(getPlayerName(localPlayer), sx/2 + 349/zoom, sy/2 + -165/zoom, (sx/2 + 349/zoom) + (42/zoom), (sy/2 + -165/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
                dxDrawText(self.plrData.premium, sx/2 + 359/zoom, sy/2 + -135/zoom, (sx/2 + 359/zoom) + (32/zoom), (sy/2 + -135/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
                dxDrawText(''..self.plrData.hours..' godzin', sx/2 + 335/zoom, sy/2 + -105/zoom, (sx/2 + 335/zoom) + (56/zoom), (sy/2 + -105/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
                dxDrawText(self.plrData.lastLogin, sx/2 + 318/zoom, sy/2 + -75/zoom, (sx/2 + 318/zoom) + (73/zoom), (sy/2 + -75/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
                dxDrawText(self.plrData.registerDate, sx/2 + 318/zoom, sy/2 + -45/zoom, (sx/2 + 318/zoom) + (73/zoom), (sy/2 + -45/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
                dxDrawText((self.plrData.faction and self.plrData.faction or 'Brak'), sx/2 + 359/zoom, sy/2 + -15/zoom, (sx/2 + 359/zoom) + (32/zoom), (sy/2 + -15/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
                dxDrawImage(sx/2 + -149/zoom, sy/2 + 55/zoom, 280/zoom, 235/zoom,self.textures['daily_task_bg'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText('Aktualne zadanie dzienne', sx/2 + -105/zoom, sy/2 + 64/zoom, (sx/2 + -110/zoom) + (198/zoom), (sy/2 + 66/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawImage(sx/2 + 168/zoom, sy/2 + 56/zoom, 280/zoom, 235/zoom, self.textures['money_bg'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText('Posiadana gotówka', sx/2 + 213/zoom, sy/2 + 66/zoom, (sx/2 + 206/zoom) + (150/zoom), (sy/2 + 65/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                if (self.actuallTask) then
                    dxDrawText(self.actuallTask.title, sx/2 + -111/zoom, sy/2 + 124/zoom, (sx/2 + -111/zoom) + (205/zoom), (sy/2 + 124/zoom) + (30/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[6], 'center', 'top')
                    dxDrawText('ZADANIE DZIENNE', sx/2 + -71/zoom, sy/2 + 166/zoom, (sx/2 + -71/zoom) + (125/zoom), (sy/2 + 166/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'center', 'top')
                    dxDrawText(self.actuallTask.progressText, sx/2 + -54/zoom, sy/2 + 204/zoom, (sx/2 + -54/zoom) + (90/zoom), (sy/2 + 204/zoom) + (30/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[6], 'center', 'top')
                    dxDrawText(self.actuallTask.state, sx/2 + -51/zoom, sy/2 + 246/zoom, (sx/2 + -51/zoom) + (86/zoom), (sy/2 + 246/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'center', 'top')
                end
                dxDrawText(addCommas(getPlayerMoney(localPlayer))..'$', sx/2 + 293/zoom, sy/2 + 125/zoom, (sx/2 + 293/zoom) + (30/zoom), (sy/2 + 125/zoom) + (30/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[6], 'center', 'top')
                dxDrawText('GOTÓWKA PRZY SOBIE', sx/2 + 232/zoom, sy/2 + 167/zoom, (sx/2 + 232/zoom) + (155/zoom), (sy/2 + 167/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'center', 'top')
                dxDrawText(addCommas(self.plrData.bankMoney)..'$', sx/2 + 257/zoom, sy/2 + 205/zoom, (sx/2 + 257/zoom) + (103/zoom), (sy/2 + 205/zoom) + (30/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[6], 'center', 'top')
                dxDrawText('GOTÓWKA W BANKU', sx/2 + 239/zoom, sy/2 + 247/zoom, (sx/2 + 239/zoom) + (141/zoom), (sy/2 + 247/zoom) + (18/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'center', 'top')
            end,
            y = sy/2-200/zoom + 52/zoom,
            icon = 'main'
        },
        {
            name = 'Zadania',
            enter = function ()
            end,
            exit = function ()
            end,
            render = function ()
                local x, y = sx/2-170/zoom, sy/2-225/zoom
                for i,v in pairs(self.tasks) do
                    if not v.ended then v.ended = math.random(20,60) end
                    dxDrawImage(x,y, 200/zoom, 160/zoom, self.textures[v.texture], 0,0,0,tocolor(255,255,255,self.alpha[2]))
                    dxDrawImage(x + 15/zoom/2,y + 13/zoom/2, 18/zoom, 18/zoom, self.textures['task_icon'], 0,0,0,tocolor(255,255,255,self.alpha[2]))
                    dxDrawText('Zadanie #'..i, x + 30/zoom, y + 33/zoom/2, nil, nil, tocolor(233,233,233,self.alpha[2]),1,self.fonts[7],'left','center')
                    dxDrawRectangle(x,y + 30/zoom, 200/zoom, 2/zoom, tocolor(68,68,68,self.alpha[2]))
                    dxDrawText(v.description, x + 200/2/zoom, y + 40/zoom, nil, nil, tocolor(187,187,187,self.alpha[2]),1,self.fonts[2],'center','top')
                    if (v.texture == 'task_red') then
                        --dxDrawText('Ukoncz obecne zadanie\naby zaczac nowe', x + 200/2/zoom, y + 160/2/zoom, nil, nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'center','center')
                    elseif (v.texture == 'task_orange') then
                        dxDrawText('50/100%', x + 200/2/zoom, y + 160/2/zoom, nil, nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[6],'center','center')
                    elseif (v.texture == 'task_green') then
                        dxDrawText('100/100%', x + 200/2/zoom, y + 160/2/zoom, nil, nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[6],'center','center')
                        dxDrawText('Ukonczowo w '..v.ended..' minut', x + 200/2/zoom, y + 230/2/zoom, nil, nil, tocolor(187,187,187,self.alpha[2]),1,self.fonts[2],'center','center')
                    end
                    x = x + 220/zoom
                    if (x > sx/2+300/zoom) then
                        x = sx/2-390/zoom + 220/zoom
                        y = y + 180/zoom
                    end
                end
            end,
            y = sy/2-200/zoom + 52/zoom + 52/zoom,
            icon = 'task'
        },
        {
            name = 'Nagroda dzienna',
            enter = function ()
            end,
            exit = function ()
            end,
            render = function ()
                local tommorow = ""
                for i = 1, 13 do
                    local pos = math.random(1, #("abcdfghijklmnoprstyuwz"))
                    tommorow = tommorow .. ("abcdfghijklmnoprstyuwz"):sub(pos,pos) .. (i==6 and "\n" or "")
                end
                dxDrawImage(sx/2 + -170/zoom, sy/2 + -224/zoom, 200/zoom, 270/zoom, self.textures['daily_award_earned'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawImage(sx/2 + -170/zoom + 17/2/zoom, sy/2 + -224/zoom + 14/zoom/2, 18/zoom, 18/zoom, self.textures['task_icon'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText('Dzien 1', sx/2 + -170/zoom + 63/2/zoom, sy/2 + -224/zoom + 33/zoom/2, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[7],'left','center')
                dxDrawText('1', sx/2 + -85/zoom, sy/2 + -178/zoom, (sx/2 + -85/zoom) + (29/zoom), (sy/2 + -178/zoom) + (46/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[8], 'center', 'top')
                dxDrawText('Dzień', sx/2 + -97/zoom, sy/2 + -120/zoom, (sx/2 + -97/zoom) + (54/zoom), (sy/2 + -120/zoom) + (25/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[5], 'center', 'top')
                dxDrawText('Nagroda odebrana', sx/2 + -129.99999618530273/zoom, sy/2 + -83/zoom, (sx/2 + -129.99999618530273/zoom) + (121/zoom), (sy/2 + -83/zoom) + (18/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'center', 'top')
                dxDrawImage(sx/2 + 50/zoom, sy/2 + -224/zoom, 200/zoom, 270/zoom, self.textures['daily_award_toget'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawImage(sx/2 + 50/zoom + 17/2/zoom, sy/2 + -224/zoom + 14/zoom/2, 18/zoom, 18/zoom, self.textures['task_icon'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText('Dzien 2', sx/2 + 50/zoom + 63/2/zoom, sy/2 + -224/zoom + 33/zoom/2, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[7],'left','center')
                dxDrawText('2', sx/2 + 135/zoom, sy/2 + -178/zoom, (sx/2 + 135/zoom) + (29/zoom), (sy/2 + -178/zoom) + (46/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[8], 'center', 'top')
                dxDrawText('Dzień', sx/2 + 123/zoom, sy/2 + -120/zoom, (sx/2 + 123/zoom) + (54/zoom), (sy/2 + -120/zoom) + (25/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[5], 'center', 'top')
                dxDrawText('Nagroda do odebrania', sx/2 + 78.00000381469727/zoom, sy/2 + -83/zoom, (sx/2 + 78.00000381469727/zoom) + (144/zoom), (sy/2 + -83/zoom) + (18/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'center', 'top')
                dxDrawImage(sx/2 + 270/zoom, sy/2 + -224/zoom, 200/zoom, 270/zoom, self.textures['daily_award_nextday'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawImage(sx/2 + 270/zoom + 17/2/zoom, sy/2 + -224/zoom + 14/zoom/2, 18/zoom, 18/zoom, self.textures['task_icon'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText('Dzien 3', sx/2 + 270/zoom + 63/2/zoom, sy/2 + -224/zoom + 33/zoom/2, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[7],'left','center')
                dxDrawText('3', sx/2 + 355/zoom, sy/2 + -178/zoom, (sx/2 + 355/zoom) + (29/zoom), (sy/2 + -178/zoom) + (46/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[8], 'center', 'top')
                dxDrawText('Dzień', sx/2 + 343/zoom, sy/2 + -120/zoom, (sx/2 + 343/zoom) + (54/zoom), (sy/2 + -120/zoom) + (25/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[5], 'center', 'top')
                dxDrawText(tommorow, sx/2 + 343/zoom, sy/2 + -90/zoom, (sx/2 + 343/zoom) + (54/zoom), (sy/2 + -120/zoom) + (25/zoom), tocolor(195, 76, 76, self.alpha[2]), 1, self.fonts['chinese'], 'center', 'top')
                dxDrawText('Nagroda do odebrania jutro', sx/2 + 343/zoom, sy/2, (sx/2 + 343/zoom) + (54/zoom), (sy/2 + -120/zoom) + (25/zoom), tocolor(195, 76, 76, self.alpha[2]), 1, self.fonts[2], 'center', 'top')
                dxDrawImage(sx/2 + 71.00000381469727/zoom, sy/2 + -1/zoom, 158/zoom, 26/zoom,self.textures['button_daily'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2 + 71.00000381469727/zoom, sy/2 + -1/zoom, 158/zoom, 26/zoom) and 255 or 150) or self.alpha[2]*0.5)))
                dxDrawText('Odbierz nagrodę', sx/2 + 94.00000381469727/zoom, sy/2, (sx/2 + 94.00000381469727/zoom) + (112/zoom), (sy/2 + 3/zoom) + (18/zoom), tocolor(238, 242, 239, (not self.animation and (isMouseInPosition(sx/2 + 71.00000381469727/zoom, sy/2 + -1/zoom, 158/zoom, 26/zoom) and 255 or 150) or self.alpha[2]*0.5)), 1, self.fonts[2], 'center', 'top')
                dxDrawText('Nagroda odebrana', sx/2 + -131.99999618530273/zoom, sy/2 + 3/zoom, (sx/2 + -131.99999618530273/zoom) + (123/zoom), (sy/2 + 3/zoom) + (18/zoom), tocolor(56, 175, 89, self.alpha[2]), 1, self.fonts[2], 'center', 'top')
                dxDrawRectangle(sx/2 + -170/zoom, sy/2 + 84/zoom, 640/zoom, 2/zoom, tocolor(68,68,68,self.alpha[2]))
                dxDrawText('Informacje z nagrody dziennej', sx/2 + -157/zoom, sy/2 + 119/zoom, (sx/2 + -157/zoom) + (231/zoom), (sy/2 + 119/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawImage(sx/2 + -157/zoom - 12/zoom, sy/2 + 119/zoom + 8/zoom, 8/zoom, 8/zoom, self.textures['circle'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText('Całkowita ilość zdobytych pieniędzy', sx/2 + -150/zoom, sy/2 + 172/zoom, (sx/2 + -150/zoom) + (269/zoom), (sy/2 + 172/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText('Całkowita ilość zdobytych punktów doświadczenia', sx/2 + -150/zoom, sy/2 + 210/zoom, (sx/2 + -150/zoom) + (374/zoom), (sy/2 + 210/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText('Całkowita ilość zdobytych punktów premium', sx/2 + -150/zoom, sy/2 + 248/zoom, (sx/2 + -150/zoom) + (333/zoom), (sy/2 + 248/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[2], 'left', 'top')
                dxDrawText('0 pp', sx/2 + 378/zoom, sy/2 + 248/zoom, (sx/2 + 378/zoom) + (61/zoom), (sy/2 + 248/zoom) + (20/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
                dxDrawText('0 xp', sx/2 + 378/zoom, sy/2 + 210/zoom, (sx/2 + 378/zoom) + (61/zoom), (sy/2 + 248/zoom) + (20/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
                dxDrawText('0 $', sx/2 + 378/zoom, sy/2 + 172/zoom, (sx/2 + 378/zoom) + (61/zoom), (sy/2 + 248/zoom) + (20/zoom), tocolor(187, 187, 187, self.alpha[2]), 1, self.fonts[2], 'right', 'top')
            end,
            y = sy/2-200/zoom + 52/zoom + 52/zoom + 52/zoom,
            icon = 'daily'
        },
        {
            name = 'Kary gracza',
            enter = function ()
            end,
            exit = function ()
            end,
            render = function ()
                dxDrawRectangle(sx/2 + -149/zoom, sy/2 + -202/zoom, 599/zoom, 2/zoom,tocolor(68,68,68,self.alpha[2]))
                dxDrawText('Data', sx/2 + -149/zoom, sy/2 + -241/zoom, (sx/2 + -149/zoom) + (39/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawText('Nick administratora', sx/2 + -43/zoom, sy/2 + -241/zoom, (sx/2 + -43/zoom) + (154/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawText('Rodzaj kary', sx/2 + 139/zoom, sy/2 + -241/zoom, (sx/2 + 139/zoom) + (91/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawText('Czas', sx/2 + 258/zoom, sy/2 + -241/zoom, (sx/2 + 258/zoom) + (37/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawText('Powód', sx/2 + 328/zoom, sy/2 + -241/zoom, (sx/2 + 328/zoom) + (54/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                local offset = 0
                for i,v in pairs(self.punish) do
                    offset = offset + dxGetFontHeight(1,self.fonts[2])
                    dxDrawText(v.date, sx/2 + -149/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                    dxDrawText(v.nick, sx/2 + -43/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                    dxDrawText(v.type, sx/2 + 139/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                    dxDrawText(v.time, sx/2 + 258/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                    dxDrawText(v.reason, sx/2 + 328/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                end
            end,
            y = sy/2-200/zoom + 52/zoom + 52/zoom + 52/zoom + 52/zoom,
            icon = 'punish'
        },
        {
            name = 'Posiadane pojazdy',
            enter = function ()
            end,
            exit = function ()
            end,
            render = function ()
                dxDrawRectangle(sx/2 + -149/zoom, sy/2 + -202/zoom, 599/zoom, 2/zoom,tocolor(68,68,68,self.alpha[2]))
                dxDrawText('ID pojazdu', sx/2 + -150/zoom, sy/2 + -241/zoom, (sx/2 + -150/zoom) + (83/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawText('Model', sx/2 + -22/zoom, sy/2 + -241/zoom, (sx/2 + -22/zoom) + (51/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawText('Ost. kierowca', sx/2 + 92/zoom, sy/2 + -241/zoom, (sx/2 + 92/zoom) + (106/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                dxDrawText('Lokalizacja', sx/2 + 240/zoom, sy/2 + -241/zoom, (sx/2 + 240/zoom) + (87/zoom), (sy/2 + -241/zoom) + (20/zoom), tocolor(232, 232, 232, self.alpha[2]), 1, self.fonts[3], 'left', 'top')
                local offset = 0
                for i,v in pairs(self.vehicles) do
                    offset = offset + dxGetFontHeight(1,self.fonts[2])
                    dxDrawText(i, sx/2 + -150/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                    dxDrawText(getVehicleNameFromModel(v.model), sx/2 + -22/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                    dxDrawText(v.lastDriver, sx/2 + 92/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                    dxDrawText(getZoneName(unpack(v.locate)), sx/2 + 240/zoom, sy/2-200/zoom+offset, nil, nil, tocolor(232, 232, 232,self.alpha[2]),1,self.fonts[2],'left','center')
                end
            end,
            y = sy/2-200/zoom + 52/zoom + 52/zoom + 52/zoom + 52/zoom + 52/zoom,
            icon = 'car'
        },
        {
            name = 'Ustawienia',
            enter = function ()
            end,
            exit = function ()
            end,
            render = function (self)
            end,
            y = sy/2-200/zoom + 52/zoom + 52/zoom + 52/zoom + 52/zoom + 52/zoom + 52/zoom,
            icon = 'settings'
        }
    }
end