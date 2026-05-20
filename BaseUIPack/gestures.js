let startY = 0;
let isDragging = false;

drawerHandle.addEventListener("touchstart", e => {
  isDragging = true;
  startY = e.touches[0].clientY;
});

drawerHandle.addEventListener("touchmove", e => {
  if (!isDragging) return;
  const dy = e.touches[0].clientY - startY;
  if (dy < -30) {
    drawer.classList.add("open");
  }
  if (dy > 30) {
    drawer.classList.remove("open");
  }
});

drawerHandle.addEventListener("touchend", () => {
  isDragging = false;
});

// Optional: swipe up from bottom area
document.body.addEventListener("touchstart", e => {
  if (e.touches[0].clientY > window.innerHeight - 40) {
    startY = e.touches[0].clientY;
    isDragging = true;
  }
});
