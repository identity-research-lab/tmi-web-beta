// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

import { copyToClipboard } from "copy_to_clipboard"
import { setupMobileNav } from "mobile_navigation"
import { handleSchemaForms } from "schema_editing"

document.addEventListener("turbo:load", () => {
  setupMobileNav()
  handleSchemaForms()
})

window.copyToClipboard = copyToClipboard
