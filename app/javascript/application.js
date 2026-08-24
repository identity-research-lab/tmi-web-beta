// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

import { copyToClipboard } from "copy_to_clipboard"
import { setupMobileNav } from "mobile_navigation"
import { handleSchemaForms } from "schema_editing"
import { sortTable } from "sort_table"
import { handleMetricsSelect } from "code_metrics"
import { handleModeSelect } from "code_metrics"
import { setMode } from "code_metrics"
import { sortCodes } from "code_metrics"
import { handleCodingForms } from "coding"
import { highlightSearchTerm } from "searching"
import { handleSearchFilters } from "searching"
import { handleLiveSearch } from "searching"
import { handleSearchSort } from "searching"
import { handleSearchPagination } from "searching"
import { fireFilters } from "searching"

document.addEventListener("turbo:frame-load", () => {
  fireFilters()
})

document.addEventListener("turbo:load", () => {
  setupMobileNav()
  handleSchemaForms()
  handleCodingForms()
  handleMetricsSelect()
  handleModeSelect()
  highlightSearchTerm()
  handleLiveSearch()
  handleSearchFilters()
  handleSearchSort()
  handleSearchPagination()
})

window.copyToClipboard = copyToClipboard
window.sortTable = sortTable
window.sortCodes = sortCodes
window.handleLiveSearch = handleLiveSearch
window.handleSearchFilters = handleSearchFilters
window.highlightSearchTerm = highlightSearchTerm
window.handleSearchSort = handleSearchSort
window.handleSearchPagination = handleSearchPagination
window.fireFilters = fireFilters
window.setMode = setMode