const homescreenGrid = document.getElementById("homescreen-grid");
const drawer = document.getElementById("drawer");
const drawerHandle = document.getElementById("drawer-handle");
const drawerList = document.getElementById("drawer-list");
const wallpaperEl = document.getElementById("wallpaper");
const wallpaperPicker = document.getElementById("wallpaper-picker");

let apps = [];
let layout = { homescreen: [] }; // [{ packageName, x, y }]

async function init() {
  apps = await BaseUI.getApps();
  layout = await BaseUI.loadLayout() || { homescreen: [] };

  renderDrawer();
  renderHomescreen();
  initWallpaperPicker();
}

function renderDrawer() {
  drawerList.innerHTML = "";
  apps.forEach(app => {
    const item = document.createElement("div");
    item.className = "drawer-app";
    item.draggable = true;
    item.dataset.packageName = app.packageName;

    const icon = document.createElement("div");
    icon.className = "app-icon";
    icon.style.backgroundImage = `url(${app.iconUri})`;

    const label = document.createElement("div");
    label.className = "app-label";
    label.textContent = app.label;

    item.appendChild(icon);
    item.appendChild(label);

    item.addEventListener("dblclick", () => BaseUI.launchApp(app.packageName));
    item.addEventListener("dragstart", onDrawerDragStart);

    drawerList.appendChild(item);
  });
}

function renderHomescreen() {
  homescreenGrid.innerHTML = "";
  layout.homescreen.forEach(entry => {
    const app = apps.find(a => a.packageName === entry.packageName);
    if (!app) return;

    const cell = document.createElement("div");
    cell.className = "homescreen-cell";

    const icon = document.createElement("div");
    icon.className = "app-icon";
    icon.style.backgroundImage = `url(${app.iconUri})`;

    const label = document.createElement("div");
    label.className = "app-label";
    label.textContent = app.label;

    cell.appendChild(icon);
    cell.appendChild(label);

    cell.addEventListener("click", () => BaseUI.launchApp(app.packageName));

    homescreenGrid.appendChild(cell);
  });

  // Make grid a drop target
  homescreenGrid.addEventListener("dragover", e => e.preventDefault());
  homescreenGrid.addEventListener("drop", onHomescreenDrop);
}

function onDrawerDragStart(e) {
  e.dataTransfer.setData("text/plain", e.target.dataset.packageName);
}

function onHomescreenDrop(e) {
  e.preventDefault();
  const pkg = e.dataTransfer.getData("text/plain");
  if (!pkg) return;

  // Simple: append to layout (no exact x/y for now)
  layout.homescreen.push({ packageName: pkg });
  BaseUI.saveLayout(layout);
  renderHomescreen();
}

function initWallpaperPicker() {
  const imgs = wallpaperPicker.querySelectorAll("img");
  imgs.forEach(img => {
    img.addEventListener("click", () => {
      imgs.forEach(i => i.classList.remove("selected"));
      img.classList.add("selected");

      const path = img.dataset.wallpaper;
      wallpaperEl.style.backgroundImage = `url(${path})`;
      BaseUI.setWallpaper(path);
    });
  });

  // Default wallpaper
  const first = imgs[0];
  if (first) {
    first.classList.add("selected");
    wallpaperEl.style.backgroundImage = `url(${first.dataset.wallpaper})`;
  }
}

init();
