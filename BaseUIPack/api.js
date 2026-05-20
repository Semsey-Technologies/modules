window.BaseUI = {
  async getApps() {
    return JSON.parse(Claudia.getInstalledApps());
  },

  async loadLayout() {
    try {
      return JSON.parse(Claudia.loadLayout() || "{}");
    } catch {
      return {};
    }
  },

  saveLayout(layout) {
    Claudia.saveLayout(JSON.stringify(layout));
  },

  setWallpaper(path) {
    Claudia.setWallpaper(path);
  },

  launchApp(pkg) {
    Claudia.launchApp(pkg);
  }
};
