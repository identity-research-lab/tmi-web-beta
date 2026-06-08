export function setupMobileNav() {
  const menuButton = document.querySelector(".mobile-menu")
  const nav = document.querySelector(".mobile-nav")

  if (!menuButton || !nav) return

  menuButton.addEventListener("click", () => {
    const isHidden = nav.classList.toggle("hidden")

    menuButton.setAttribute("aria-expanded", String(!isHidden))
  })
}
