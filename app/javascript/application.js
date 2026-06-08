// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

import { copyToClipboard } from "copy_to_clipboard"
import { setupMobileNav } from "mobile_navigation"

document.addEventListener("turbo:load", () => {
  setupMobileNav()
})

window.copyToClipboard = copyToClipboard
