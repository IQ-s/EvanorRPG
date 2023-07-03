addEvent('copyText',true)
addEventHandler('copyText', root, function (text)
    setClipboard(text)
end)