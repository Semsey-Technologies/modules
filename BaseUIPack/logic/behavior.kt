package base_ui_pack.logic

import claudia.shell.api.*

class BaseUIBehavior : ModuleBehavior() {

    override fun onStart() {
        // Initialize settings
        applySettings()
        
        // Default content mode
        setContentMode("apps")
    }

    /**
     * DSL-like function for switching content modes
     */
    fun setContentMode(mode: String) {
        val content = findView("main_content")
        content.switchToMode(mode)
    }

    fun toggleWifi() {
        SystemServices.wifi.toggle()
    }

    fun toggleBluetooth() {
        SystemServices.bluetooth.toggle()
    }

    fun toggleFlashlight() {
        SystemServices.flashlight.toggle()
    }

    private fun applySettings() {
        val theme = getSetting("themeMode")
        val accent = getSetting("accentColor")
        val blur = getSetting("blurBackground")
        val corners = getSetting("roundedCorners")
        
        // Apply to UI using the Claudia Shell API
        UI.setTheme(theme)
        UI.setAccentColor(accent)
        UI.enableBlur(blur)
        UI.setCornerRadius(if (corners) 16 else 0)
    }
}
