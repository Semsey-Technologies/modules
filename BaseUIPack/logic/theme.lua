local T = {}

function T.init(launcher)
    T.launcher = launcher
end

function T.getHomescreenStyle()
    return {
        textColor = "#FFFFFF",
        iconSize = 56
    }
end

function T.getDrawerStyle()
    return {
        backgroundColor = "#000000",
        textColor = "#FFFFFF"
    }
end

function T.getSettingsItems()
    return {
        { type = "button", id = "theme_dark", label = "Dark Mode" },
        { type = "button", id = "theme_light", label = "Light Mode" }
    }
end

function T.handleSettingsEvent(event)
    print("Theme event: " .. event.id)
end

return T
