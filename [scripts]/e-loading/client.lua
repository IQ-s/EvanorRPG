local maxUpdates = 3
local loading = {
	progress = 0.4,
	update = 1,
	reason = false,
	description = false,
}
a.progress = {0, 0, 100}

local fonts = {
	[1] = exports['e-gui']:getFont('medium',13.4/zoom),
	[2] = exports['e-gui']:getFont('medium',19/zoom),
	[3] = exports['e-gui']:getFont('regular',13.3/zoom)
}

local updatesInfos = {
	{
		title = 'Serwis #38AF59pojazdów',
		description = wordWrap('Pamiętaj o regularnym serwisowaniu swoich pojazdów, wymieniaj w nich płyn chłodniczy, hamulcowy oraz staraj się nie przegrzewać silnika, gdyż może spowodować to jego uszkodzenie!', 560/zoom, 1, fonts[1]),
	},
	{
		title = 'Zabezpiecz #38AF59swoje konto',
		description = wordWrap('Uruchom weryfikację dwuetapową w ustawieniach swojego konta w dashboardzie (F5) poprzez Google Authenticator w celu zabezpieczenia swojego konta, przy każdym logowaniu będzie od ciebie wymagany 6-cyfrowy kod', 560/zoom, 1, fonts[1]),
	},
	{
		title = 'Jazda #38AF59po zmroku',
		description = wordWrap('Po zmroku uważaj na zwierzęta pojawiające się na drodze, twój pojazd może uledz uszkodzeniu podczas kolizji!', 560/zoom, 1, fonts[1]),
	},
}

local rot = 0

function renderUI()
	if not loading.reason or not loading.description then return end
	showChat(false)

	local function drawUpdate(x, y, w, h, id, opacity, op)
		dxSetShaderValue(loading.shader, 'sPicTexture', textures[tostring(id)].texture)
		dxDrawImage(x, y, w, h, loading.shader, 0, 0, 0, tocolor(255, 255, 255, 255*a['opacity'] * (op or 1)), true)
		dxDrawImage(x, y, w, h, textures[tostring(id)].texture, 0, 0, 0, tocolor(255, 255, 255, 255*a['opacity']*opacity * (op or 1)), true)

		local update = updatesInfos[id]
		if not update then return end
		local description = update.description
		local size = 0.8 + opacity*0.2
		dxDrawText(update.title, x + 15/zoom, y - 15/zoom + h - #description * (22/zoom*size), nil, nil, tocolor(255,255,255,255*opacity*a['opacity']), size, fonts[2], 'left', 'bottom', false, false, true,true)
		for k,v in pairs(description) do
			dxDrawText(v, x + 15/zoom, y - 15/zoom + h - #description * (22/zoom*size) + (k-1)*(22/zoom*size), nil, nil, tocolor(255,255,255,200*opacity*a['opacity']), size, fonts[1], nil, nil, false, false, true)
		end
	end

	dxDrawImage(0, 0, sx, sy, textures.background.texture, 0, 0, 0, tocolor(255, 255, 255, 255*a['opacity']), true)
	dxDrawImage(0,0,sx,sy, textures.left_light.texture, 0, 0, 0, tocolor(255, 255, 255, 255*a['opacity']), true)
	dxDrawImage(0,0,sx,sy, textures.right_light.texture, 0, 0, 0, tocolor(255, 255, 255, 255*a['opacity']), true)
	dxDrawImage(sx/2-150/2/zoom,sy/2-490/zoom,150/zoom,150/zoom,textures.logo.texture, 0, 0, 0, tocolor(255, 255, 255, 255*a['opacity']), true)
	dxDrawImage(sx-70/zoom,sy-70/zoom,40/zoom,40/zoom,textures.loading.texture, a['test'], 0, 0, tocolor(255, 255, 255, 255*a['opacity']), true)

	dxDrawText('Ciekawostka', 40/zoom, sy-70/zoom,nil,nil,tocolor(56,175,89,255*a['opacity']),1,fonts[2],'left','center',false,false,true)
	dxDrawText(loading.reason, sx-80/zoom, sy-53/zoom,nil,nil,tocolor(255,255,255,255*a['opacity']),1,fonts[2],'right','center',false,false,true)
	dxDrawText('Czy wiedziales, ze w Gta San Andreas\nznajduja sie 3 duze miasta?', 40/zoom, sy-60/zoom,nil,nil,tocolor(255,255,255,255*a['opacity']),1,fonts[3],'left','top',false,false,true)
	
	drawUpdate(sx/2 - 850/zoom - 350/zoom*a['update'], sy/2 - 150/zoom + 25/zoom*a['update'] - 100/zoom, 500/zoom - 100/zoom*a['update'], 550/zoom , (loading.update-1)%maxUpdates+1, 0, 1 - a['update'])
	drawUpdate(sx/2 - 300/zoom - 550/zoom*a['update'], sy/2 - 175/zoom + 25/zoom*a['update'] - 100/zoom, 600/zoom - 100/zoom*a['update'], 550/zoom, loading.update%maxUpdates+1, 1-a['update'])
	drawUpdate(sx/2 + 350/zoom - 650/zoom*a['update'], sy/2 - 150/zoom - 25/zoom*a['update'] - 100/zoom, 500/zoom + 100/zoom*a['update'], 550/zoom, (loading.update+1)%maxUpdates+1, a['update'])
	drawUpdate(sx/2 + 700/zoom - 350/zoom*a['update'], sy/2 - 125/zoom - 25/zoom*a['update'] - 100/zoom, 400/zoom + 100/zoom*a['update'], 550/zoom, (loading.update+2)%maxUpdates+1, 0, a['update'])
end

function nextUpdate()
	a['update'] = {0, 1, 900, 'InOutQuad'}
	loading.update = loading.update + 1
	if loading.update > maxUpdates then
		loading.update = 1
	end
end

function updateVolume()
	if loading.music and isElement(loading.music) then
		local volume = getSoundVolume(loading.music)
		setSoundVolume(loading.music, volume + loading.volumeChange)
	end
end

function toggleUI(visible)
	loading.visible = visible
    local eventCallback = visible and addEventHandler or removeEventHandler

    eventCallback('onClientRender', root, renderUI, true, 'low-9999')
	showCursor(visible)
    if visible then
		loadTextures({
			{'background', 'data/background.png'},
			{'barbackground', 'data/bar-background.png'},
			{'bar', 'data/bar.png'},
			{'dotActive', 'data/dot-active.png'},
			{'dot', 'data/dot.png'},
			{'mask', 'data/mask.png'},
			{'1', 'data/1.png'},
			{'3', 'data/3.png'},
			{'2', 'data/2.png'},
			{'left_light', 'data/left_light.png'},
			{'right_light', 'data/right_light.png'},
			{'logo', 'data/logo.png'},
			{'loading','data/loading.png'}
		})

		loading.shader = dxCreateShader('data/mask.fx')
		dxSetShaderValue(loading.shader, 'sMaskTexture', textures.mask.texture)

		a['opacity'] = {0, 1, 500, 'OutQuad'}
		loading.updateTimer = setTimer(nextUpdate, 4000, 0)
		a['test'] = {a['test'], 500, 1000, 'Linear'}
		loading.loadTimer = setTimer(function ()
			a['test'] = {a['test'], a['test'] + 500, 1000, 'Linear'}
		end,950,0)
		loading.music = playSound('data/music.mp3', true)
		setSoundVolume(loading.music, 0)
		loading.volumeChange = 0.3
		loading.volumeTimer = setTimer(updateVolume, 100, 10)
		nextUpdate()
    else
        unloadTextures()
		if loading.shader and isElement(loading.shader) then destroyElement(loading.shader) end
		if loading.music and isElement(loading.music) then destroyElement(loading.music) end
		if loading.updateTimer and isTimer(loading.updateTimer) then killTimer(loading.updateTimer) end
		if loading.volumeTimer and isTimer(loading.volumeTimer) then killTimer(loading.volumeTimer) end
    end
end

function hideLoading()
	a['opacity'] = {a['opacity'] or 1, 0, 500, 'OutQuad'}
	setTimer(toggleUI, 500, 1, false)
	setSoundVolume(loading.music, 3)
	loading.volumeChange = -0.3
	loading.volumeTimer = setTimer(updateVolume, 100, 10)
end

function showLoading(reason, description, time)
	loading.reason = reason
	loading.description = description
	if not loading.visible then
		toggleUI(true)
	end

	if loading.hideTimer and isTimer(loading.hideTimer) then
		killTimer(loading.hideTimer)
		killTimer(loading.loadTimer)
	end

	if time then
		loading.hideTimer = setTimer(hideLoading, time, 1)
	end
end

function isActive()
	return loading.visible
end

function setText(a, b)
	loading.reason = a
	if b then loading.description = b end
end

function setProgress(progress)
	a.progress = {a.progress or 0, progress, 300, 'OutQuad'}
end

local download = {
	last = false,
	speed = 0,
	current = false
}

setTimer(function()
	download.current = download.speed*2
	download.speed = 0
end, 500, 0)

addEventHandler("onClientTransferBoxProgressChange", root, function(downloadedSize, totalSize)
	if not loading.visible then
		showLoading('', '')
	end

    local progress = math.min(downloadedSize / totalSize, 1)
    setProgress(progress)
	loading.reason = 'Trwa pobieranie zasobów'

	if download.current then
		loading.description = ('Zasoby są pobieranie z prędkością #E8C773%.2fmb/s'):format(download.current/1024/1024)
	else
		loading.description = 'Trwa obliczanie prędkości pobierania...'
	end

	download.last = download.last or downloadedSize
	download.speed = download.speed + (downloadedSize - download.last)
	download.last = downloadedSize

	setTransferBoxVisible(false)
end)

addEventHandler("onClientTransferBoxVisibilityChange", root, function(isVisible)
    if loading.visible and loading.reason == 'Trwa pobieranie zasobów' and not isVisible then
		hideLoading()
	end
end)

--showLoading('Ładowanie...', 'Trwa wczytywanie interioru', 7000)