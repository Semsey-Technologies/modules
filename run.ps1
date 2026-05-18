Write-Host "=== Building Base UI Pack (Lua) ==="

$root = Join-Path $PSScriptRoot "BaseUIPack"
$logic = Join-Path $root "logic"

if (Test-Path $root) { Remove-Item $root -Recurse -Force }

New-Item -ItemType Directory -Path $root | Out-Null
New-Item -ItemType Directory -Path $logic | Out-Null

# -------------------------
# Write module.json
# -------------------------
$moduleJson = @(
'{'
'  "id": "base_ui_pack",'
'  "name": "Base UI Pack",'
'  "version": "1.0.0",'
'  "description": "Standard launcher UI plus advanced actions, implemented in Lua.",'
'  "author": "Semsey Technologies",'
'  "entrypoint": "logic/main.lua"'
'}'
)

$moduleJson | Out-File -Encoding UTF8 (Join-Path $root "module.json")

# -------------------------
# Write logic/main.lua
# -------------------------
$lua = @(
'-- Base UI Pack (Lua Version)'
''
'function onInit()'
'    claudia.log("Base UI Pack (Lua) initialized")'
'end'
''
'function onDestroy()'
'    claudia.log("Base UI Pack (Lua) destroyed")'
'end'
''
'function onHomescreen()'
'    claudia.ui.section("Quick Actions")'
'    claudia.ui.button("Search", function() claudia.launcher.openSearch() end)'
'    claudia.ui.button("Launcher Settings", function() claudia.launcher.openSettings() end)'
''
'    claudia.ui.spacer(10)'
''
'    claudia.ui.section("System Toggles")'
'    claudia.ui.button("Toggle Wi-Fi", function() claudia.system.toggleWifi() end)'
'    claudia.ui.button("Toggle Bluetooth", function() claudia.system.toggleBluetooth() end)'
'    claudia.ui.button("Lock Screen", function() claudia.system.lockScreen() end)'
''
'    claudia.ui.spacer(10)'
''
'    claudia.ui.section("Favorites")'
'    local fav = claudia.launcher.getFavorites()'
'    if #fav == 0 then'
'        claudia.ui.text("No favorites set.")'
'    else'
'        claudia.ui.appGrid(fav, function(app) claudia.launcher.launchApp(app.package) end)'
'    end'
''
'    claudia.ui.spacer(10)'
''
'    claudia.ui.section("All Apps")'
'    local apps = claudia.launcher.getInstalledApps()'
'    claudia.ui.appGrid(apps, function(app) claudia.launcher.launchApp(app.package) end)'
'end'
''
'function onSettings()'
'    claudia.ui.section("Base UI Pack Settings")'
'    claudia.ui.text("This module provides:")'
'    claudia.ui.text("- Quick actions")'
'    claudia.ui.text("- System toggles")'
'    claudia.ui.text("- Favorites row")'
'    claudia.ui.text("- All apps grid")'
''
'    claudia.ui.spacer(10)'
''
'    claudia.ui.button("Debug Log Test", function()'
'        claudia.log("Settings button pressed")'
'        claudia.toast("Logged debug entry")'
'    end)'
'end'
)

$lua | Out-File -Encoding UTF8 (Join-Path $logic "main.lua")

Write-Host "Base UI Pack created at: $root"
Write-Host "Zip the folder to create BaseUIPack.zip"
