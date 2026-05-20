local S = {}

local launcher
local theme
local homescreen

function S.init(l, themeModule, homescreenModule)
    launcher = l
    theme = themeModule
    homescreen = homescreenModule
end

function S.show()
    launcher:showModuleSettings("Base UI Pack", {
        sections = {
            {
                title = "Layout",
                items = {
                    { type = "slider", id = "grid_cols", label = "Columns", min = 3, max = 7 },
                    { type = "slider", id = "grid_rows", label = "Rows", min = 4, max = 8 }
                }
            },
            {
                title = "Wallpaper",
                items = {
                    { type = "button", id = "wall_neon_grid", label = "Neon Grid" },
                    { type = "button", id = "wall_neon_city", label = "Neon City" },
                    { type = "file_picker", id = "wall_custom", label = "Custom Wallpaper" }
                }
            },
            {
                title = "Theme",
                items = theme.getSettingsItems()
            }
        }
    }, function(event)
        if event.id == "grid_cols" then
            homescreen.setGrid(event.value, nil)
        elseif event.id == "grid_rows" then
            homescreen.setGrid(nil, event.value)
        elseif event.id == "wall_neon_grid" then
            homescreen.setWallpaper("assets/wallpapers/neon_grid.png")
        elseif event.id == "wall_neon_city" then
            homescreen.setWallpaper("assets/wallpapers/neon_city.png")
        elseif event.id == "wall_custom" and event.path then
            homescreen.setWallpaper(event.path)
        else
            theme.handleSettingsEvent(event)
        end
    end)
end

return S
