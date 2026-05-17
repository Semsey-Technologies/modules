# Base UI Pack

A clean, modern starter UI module for Claudia Shell.

## Features
- **Header Area**: Real-time clock, date, and battery status.
- **Quick Actions**: Easy access to WiFi, Bluetooth, and Flashlight toggles.
- **Switchable Content**: Toggle between App Grid, Weather, Notes, and Media controls.
- **Fancy UI**: Optional glassmorphism (blur) and modern rounded corners.
- **Theming**: Integrated support for Light, Dark, and Auto themes with customizable accent colors.

## Customization
To customize the module, go to **Settings > Modules > Base UI Pack** in your Claudia Shell launcher.
- **Blur Background**: Enable or disable the background blur effect.
- **Rounded Corners**: Toggle between sharp edges and modern rounded corners.
- **Accent Color**: Personalize the UI with your preferred highlight color.
- **Theme Mode**: Choose between Light, Dark, or Auto (follows system preference).

## Switching Content Modes
The content area can be programmatically switched using the `setContentMode(mode)` function in `behavior.kt`. 
Available modes:
- `apps`: Displays the standard app drawer grid.
- `weather`: Shows current weather information and forecast.
- `notes`: Quick access to your latest notes.
- `media`: Playback controls for active music or video.

## Installation
1. Open the **Claudia Shell** launcher on your device.
2. Navigate to the **Module Store**.
3. Search for **Base UI Pack**.
4. Tap **Install** to add it to your launcher.
