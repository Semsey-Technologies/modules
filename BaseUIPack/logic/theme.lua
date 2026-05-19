local T = {}

local launcher

local state = {
    accent = "#00E4FF",
    glow = 0.8,
    drawer_blur = 20,
    wallpaper_overlay = "rgba(0,0,0,0.35)"
}

local function save()
    if launcher then
        launcher:saveModuleState("base_ui_pack_theme", state)
    end
end

function T.init(l)
    launcher = l
    local saved = launcher:loadModuleState("base_ui_pack_theme")
    if saved then
        state = saved
    end
end

function T.getHomescreenStyle()
    return {
        accent = state.accent,
        glow = state.glow,
        wallpaper_overlay = state.wallpaper_overlay
    }
end

function T.getDrawerStyle()
    return {
        accent = state.accent,
        glow = state.glow,
        blur = state.drawer_blur
    }
end

function T.getSettingsItems()
    return {
        {
            type = "slider",
            id = "glow",
            label = "Glow Intensity",
            min = 0,
            max = 1,
            step = 0.05,
            value = state.glow
        },
        {
            type = "slider",
            id = "drawer_blur",
            label = "Drawer Blur",
            min = 0,
            max = 40,
            step = 2,
            value = state.drawer_blur
        }
    }
end

function T.handleSettingsEvent(event)
    if event.id == "glow" then
        state.glow = event.value
        save()
    elseif event.id == "drawer_blur" then
        state.drawer_blur = event.value
        save()
    end
end

return T
