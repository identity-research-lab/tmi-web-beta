// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

import { copyToClipboard } from "copy_to_clipboard"

document.addEventListener("turbo:load", () => {
})

window.copyToClipboard = copyToClipboard
