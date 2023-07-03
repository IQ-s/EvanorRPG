--[[
    Resource: e-f1
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

sx,sy = guiGetScreenSize()
zoom = exports['e-gui']:getZoom()

pages = {
    {
        name = "Informacje o serwerze",
        icon = dxCreateTexture('data/images/i_info.png','argb',false,'clamp'),
        x = sx/2+105/zoom + 55/zoom,
        enter = function (self)
            renderID, renderData = exports['e-scroll']:createTarget({
                x = sx/2-380/zoom,
                y = sy/2-250/zoom,
                w = 719/zoom,
                h = 560/zoom,
                rtw = 719,
                rth = 560,
                alpha = true,
                max_scroll = 300/zoom,
                scrollSpeed = 15,
                noDrag = true,
                animation = true,
                anim = 0,
                
                scrollData = {
                    visible = true,
                    x = sx/2-360/zoom + 729/zoom,
                    w = 2/zoom,
                    color = {242, 242, 242},
                    thumb = {56,175,89},
                    thumbSize = 4/zoom
                }
            })
            self.updateRT()
            exports['e-scroll']:animateScroll(renderID, 300, 'InOutQuad', 0, 255)
        end,
        render = function ()
            --dxDrawRectangle(sx/2-360/zoom,sy/2-250/zoom,719/zoom,560/zoom)
        end,
        rt = function (self)
            dxDrawText(info, 0, 0, nil,nil, tocolor(255,255,255,self.alpha[2]),1,(self.fonts[2] and self.fonts[2] or 'default'),'left','top',false,false,false,true)
        end,
        leave = function ()
            if renderID then
                exports['e-scroll']:destroyTarget(renderID)
                renderID = false
                renderData = false
            end
        end,
    },
    {
        name = "Aktualizacje",
        icon = dxCreateTexture('data/images/i_changelog.png','argb',false,'clamp'),
        x = sx/2+105/zoom + 55/zoom + 55/zoom,
        enter = function (self)
            renderID, renderData = exports['e-scroll']:createTarget({
                x = sx/2-380/zoom,
                y = sy/2-250/zoom,
                w = 719/zoom,
                h = 560/zoom,
                rtw = 719,
                rth = 560,
                alpha = true,
                max_scroll = 260/zoom,
                scrollSpeed = 15,
                noDrag = true,
                animation = true,
                anim = 0,
                
                scrollData = {
                    visible = true,
                    x = sx/2-360/zoom + 729/zoom,
                    w = 2/zoom,
                    color = {242, 242, 242},
                    thumb = {56,175,89},
                    thumbSize = 4/zoom
                }
            })
            self.updateRT()
            exports['e-scroll']:animateScroll(renderID, 300, 'InOutQuad', 0, 255)
        end,
        render = function ()
        end,
        rt = function (self)
            dxDrawText(updates, 0, 0, nil,nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'left','top',false,false,false,true)
        end,
        leave = function ()
            if renderID then
                exports['e-scroll']:destroyTarget(renderID)
                renderID = false
                renderData = false
            end
        end,
    },
    {
        name = "Regulamin",
        icon = dxCreateTexture('data/images/i_rule.png','argb',false,'clamp'),
        x = sx/2+105/zoom + 55/zoom + 55/zoom + 55/zoom,
        enter = function (self)
            renderID, renderData = exports['e-scroll']:createTarget({
                x = sx/2-380/zoom,
                y = sy/2-250/zoom,
                w = 719/zoom,
                h = 560/zoom,
                rtw = 719,
                rth = 560,
                alpha = true,
                max_scroll = 300/zoom,
                scrollSpeed = 15,
                noDrag = true,
                animation = true,
                anim = 0,
                
                scrollData = {
                    visible = true,
                    x = sx/2-360/zoom + 729/zoom,
                    w = 2/zoom,
                    color = {242, 242, 242},
                    thumb = {56,175,89},
                    thumbSize = 4/zoom
                }
            })
            self.updateRT()
            exports['e-scroll']:animateScroll(renderID, 300, 'InOutQuad', 0, 255)
        end,
        render = function ()
            --dxDrawRectangle(sx/2-360/zoom,sy/2-250/zoom,719/zoom,560/zoom)
        end,
        rt = function (self)
            dxDrawText(rules, 0, 0, nil,nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'left','top',false,false,false,true)
        end,
        leave = function ()
            if renderID then
                exports['e-scroll']:destroyTarget(renderID)
                renderID = false
                renderData = false
            end
        end,
    },
    {
        name = "Przewodnik",
        icon = dxCreateTexture('data/images/i_guide.png','argb',false,'clamp'),
        x = sx/2+105/zoom + 55/zoom + 55/zoom + 55/zoom + 55/zoom,
        enter = function (self)
            renderID, renderData = exports['e-scroll']:createTarget({
                x = sx/2-380/zoom,
                y = sy/2-250/zoom,
                w = 719/zoom,
                h = 560/zoom,
                rtw = 719,
                rth = 560,
                alpha = true,
                max_scroll = 1,
                scrollSpeed = 15,
                noDrag = true,
                animation = true,
                anim = 0,
                
                scrollData = {
                    visible = true,
                    x = sx/2-360/zoom + 729/zoom,
                    w = 2/zoom,
                    color = {242, 242, 242},
                    thumb = {56,175,89},
                    thumbSize = 4/zoom
                }
            })
            self.updateRT()
            exports['e-scroll']:animateScroll(renderID, 300, 'InOutQuad', 0, 255)
        end,
        render = function ()
            --dxDrawRectangle(sx/2-360/zoom,sy/2-250/zoom,719/zoom,560/zoom)
        end,
        rt = function (self)
            dxDrawText(guide, 0, 0, nil,nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'left','top',false,false,false,true)
        end,
        leave = function ()
            if renderID then
                exports['e-scroll']:destroyTarget(renderID)
                renderID = false
                renderData = false
            end
        end,
    }
}