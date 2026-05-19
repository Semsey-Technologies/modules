local H = {}

local state = {
    icons = {},   -- { {package="com.app", x=col, y=row}, ... }
    grid = { cols = 5, rows = 6 },
    wallpaper = "assets/wallpapers/neon_grid.png"
}

function H.init(launcher, theme)
    H.launcher = launcher
    H.theme = theme

    local saved = launcher:loadModuleState("base_ui_pack_homescreen")
    if saved then
        state = saved
    end
end

local function save()
    H.launcher:saveModuleState("base_ui_pack_homescreen", state)
end

function H.show()
    H.launcher:showHomescreen({
        wallpaper = state.wallpaper,
        grid = state.grid,
        icons = state.icons,
        theme = H.theme.getHomescreenStyle()
    }, {
        onIconTap = function(icon)
            H.launcher:launchApp(icon.package)
        end,
        onIconLongPress = function(icon)
            H.launcher:showAppContextMenu(icon.package)
        end,
        onAddFromDrawer = function(app)
            table.insert(state.icons, { package = app.packageName })
            save()
            H.show()
        end,
        onReorder = function(newIcons)
            state.icons = newIcons
            save()
        end
    })
end

function H.setWallpaper(path)
    state.wallpaper = path
    save()
    H.show()
end

function H.setGrid(cols, rows)
    if cols then state.grid.cols = cols end
    if rows then state.grid.rows = rows end
    save()
    H.show()
end

return H
