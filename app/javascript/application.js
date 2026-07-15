// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

import { copyToClipboard } from "copy_to_clipboard"
import { setupMobileNav } from "mobile_navigation"
import { handleSchemaForms } from "schema_editing"
import { sortTable } from "sort_table"
import { handleSurveyItemSelect } from "code_metrics"
import { sortCodes } from "code_metrics"
import { handleCodingForms } from "coding"
import { highlightSearchTerm } from "searching"

document.addEventListener("turbo:load", () => {
  setupMobileNav()
  handleSchemaForms()
  handleCodingForms()
  handleSurveyItemSelect()
  highlightSearchTerm()
})

window.copyToClipboard = copyToClipboard
window.sortTable = sortTable
window.sortCodes = sortCodes
window.highlightSearchTerm = highlightSearchTerm
