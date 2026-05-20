local D = {}

local apps = {}

function D.init(launcher, theme)
    D.launcher = launcher
    D.theme = theme
    apps = launcher:getInstalledApps() or {}
end

function D.show()
    D.launcher:showAppDrawer({
        apps = apps,
        theme = D.theme.getDrawerStyle()
    }, {
        onAppTap = function(app)
            D.launcher:launchApp(app.packageName)
        end,
        onAppLongPress = function(app)
            D.launcher:addToHomescreen(app.packageName)
        end,
        onSearch = function(query)
            local filtered = {}
            local q = (query or ""):lower()
            for _, a in ipairs(apps) do
                if a.label and a.label:lower():find(q, 1, true) then
                    table.insert(filtered, a)
                end
            end
            D.launcher:updateAppDrawerList(filtered)
        end
    })
end

return D
