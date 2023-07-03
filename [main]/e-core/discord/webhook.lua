function sendDiscordMessage(webhook, name, msg)
    local settings = {
        formFields = {
            username = name,
            content = msg,
        },
        method = "POST"
    }
    fetchRemote(webhook, settings, function() end)
end