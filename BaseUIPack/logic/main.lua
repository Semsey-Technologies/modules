local homescreen = require("homescreen")
local appdrawer  = require("appdrawer")
local settings   = require("settings")
local theme      = require("theme")

local M = {}

function M.onInitialize(launcher)
    M.launcher = launcher

    theme.init(launcher)
    homescreen.init(launcher, theme)
    appdrawer.init(launcher, theme)
    settings.init(launcher, theme, homescreen)

    launcher:registerGesture("swipe_up", function()
        appdrawer.show()
    end)

    launcher:registerGesture("home_pressed", function()
        homescreen.show()
    end)

    homescreen.show()
end

function M.onOpenSettings()
    settings.show()
end

return M
