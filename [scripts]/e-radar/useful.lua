
main = {

    settings = {

        blipsScale = 35,
        radarSize = {400, 250},

    },

    radarData = {},
}

dxDrawLinedRectangle = function( x, y, width, height, color, _width, postGUI )
	_width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    addEventHandler('onClientRender', root, main.renderRadar, true, 'low-1')
    setPlayerHudComponentVisible('radar', false)

    main.radarData.mapTexture = dxCreateTexture('img/map.png')
    main.radarData.maskTexture = dxCreateTexture("img/mask.png")
    main.radarData.background = dxCreateTexture("img/background.png")    
    main.radarData.maskShader = dxCreateShader("mask/hud_mask.fx")    

    main.renderTarget = dxCreateRenderTarget(3072, 3072, true)

    dxSetShaderValue(main.radarData.maskShader, "sPicTexture", main.renderTarget)
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
    if isElement(main.radarData.mapTexture) then destroyElement(main.radarData.mapTexture) end
    if isElement(main.radarData.maskShader) then destroyElement(main.radarData.maskShader) end
    if isElement(main.radarData.shader3D) then destroyElement(main.radarData.shader3D) end
    if isElement(main.radarData.maskTexture) then destroyElement(main.radarData.maskTexture) end
    if isElement(main.radarData.background) then destroyElement(main.radarData.background) end
    if isElement(main.renderTarget) then destroyElement(main.renderTarget) end
    if isElement(main.rt) then destroyElement(main.rt) end
end)

sx, sy = guiGetScreenSize()
zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)*0.9
end 

main.radarData.font = exports["e-gui"]:getFont("bold", 12/zoom)
main.radarData.font2 = exports["e-gui"]:getFont("bold", 14/zoom)
main.radarData.font3 = exports["e-gui"]:getFont("light", 10/zoom)
main.radarData.font4 = exports["e-gui"]:getFont("bold", 17/zoom)
main.radarData.font5 = exports["e-gui"]:getFont("bold", 13/zoom)