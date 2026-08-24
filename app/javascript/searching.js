export function highlightSearchTerm() {
  const searchbox = document.getElementsByClassName("search-input")
  if (!searchbox) return
  const substring = searchbox[0].value
  if (!substring) return
  const elements = document.getElementsByClassName("search-result")
  const regex = new RegExp(`(${substring})`, "gi")
  for (const el of elements) { 
    el.innerHTML = el.textContent.replace(regex, '<span class="highlight">$1</span>')
  }
}

export function handleLiveSearch() {
  const input = document.getElementById("search-live")
  if (!input) return
  input.addEventListener("input", (event) => {
    const form = event.target.form
    if (!form) return
    form.requestSubmit()
    //form.submit()
  })
}

export function handleSearchPagination() {
  
  const pageButtons = document.getElementsByClassName("page-button")
  const availableWindow = document.getElementById("available-window")
  const backButton = document.getElementById("page-back")
  const nextButton = document.getElementById("page-next")
  const totalRecordsElem = document.getElementById("available-total-count")

  var startIndex = parseInt(document.getElementById("search_offset").value) + 1
  var endIndex = startIndex + parseInt(document.getElementById("search_per_page").value) - 1
  var totalCount = 0
  if (totalRecordsElem) {
    totalCount = parseInt(totalRecordsElem.innerHTML)
  }
  
  if (startIndex == 1) {
    backButton.classList.add("hidden")
  } else {
    backButton.classList.remove("hidden")
  }
  
  if (endIndex > totalCount) { 
    endIndex = totalCount 
    nextButton.classList.add("hidden")
  } else {
    nextButton.classList.remove("hidden")
  }
  availableWindow.innerHTML = startIndex + "-" + endIndex

  
  
  for (const pageButton of pageButtons) {
    pageButton.addEventListener("mousedown", (event) => {
  
      console.log(1)
      const searchForm = document.getElementById("search-form")  
      if (!searchForm) return
      
      const offset = document.getElementById("search_offset")
      if (!offset) return
  
      const perPage = document.getElementById("search_per_page")
      if (!perPage) return
      
      var totalCount = 0
      const totalRecordsElem = document.getElementById("available-total-count")
      if (totalRecordsElem) {
        totalCount = parseInt(totalRecordsElem.innerHTML)
      }
      
      var newOffset = 0
      if (event.target.dataset.direction == "back") {
        newOffset = parseInt(offset.value) - parseInt(perPage.value)
      } else {
        newOffset = parseInt(offset.value) + parseInt(perPage.value)
      }
      
      if (newOffset < 0) { newOffset = 0 }
      if (newOffset > totalCount) { newOffset = offset.value }
  
      offset.value = newOffset
  
      searchForm.requestSubmit()
      
    })
  }    
}

export function handleSearchSort() {
  
  const sortButtons = document.getElementsByClassName("search-sort-button")

  for (const sortButton of sortButtons) {
    sortButton.addEventListener("mousedown", (event) => {

      const searchForm = document.getElementById("search-form")  
      if (!searchForm) return
      
      const sortKey = document.getElementById("search_sort_key")
      if (!sortKey) return
      
      const prevSortKey = sortKey.value
      sortKey.value = sortButton.dataset.key
      
      const sortDir = document.getElementById("search_sort_dir")
      if (!sortDir) return

      if (prevSortKey == sortKey.value) {
        if (sortDir.value == "asc") { sortDir.value = "desc" } else { sortDir.value = "asc" }
      }

      searchForm.requestSubmit()
      
    })
  }
  
  
}

export function handleSearchFilters() {

  const resetFiltersButton = document.getElementById("clear-browser-filters")
  if (resetFiltersButton) {
    resetFiltersButton.addEventListener("click", (event) => {
      const form = event.target.form
      if (form) {
        form.reset()
        form.requestSubmit() 
      }
      fireFilters()
    })
  }
  
  const countFilter = document.getElementById("filter-count")
  if (countFilter) {
    countFilter.addEventListener("change", (event) => {
      fireFilters()
    })
  }

  const attachedFilter = document.getElementById("filter-attached")
  if (attachedFilter) {
    attachedFilter.addEventListener("change", (event) => {
      fireFilters()
    })
  }

  const unattachedFilter = document.getElementById("filter-unattached")
  if (unattachedFilter) {
    unattachedFilter.addEventListener("change", (event) => {
      fireFilters()
    })
  }

  const highFreqFilter = document.getElementById("filter-high-freq")
  if (highFreqFilter) {
    highFreqFilter.addEventListener("change", (event) => {
      fireFilters()
    })
  }

  const lowFreqFilter = document.getElementById("filter-low-freq")
  if (lowFreqFilter) {
    lowFreqFilter.addEventListener("change", (event) => {
      fireFilters()
    })
  }
}

export function fireFilters() {
  const filterables = document.getElementsByClassName("filterable")
  for (const filterable of filterables) {
    filterable.classList.remove("hidden")
  }
  
  const countFilter = document.getElementById("filter-count")
  if (countFilter) {
    for (const el of filterables) {
      if (countFilter.checked == true) {
        if (el.dataset.count != "0") {
          el.classList.add("hidden")
        }
      }
    }
  }

  const attachedFilter = document.getElementById("filter-attached")
  if (attachedFilter) {
    if (attachedFilter.checked == true) {
      for (const el of filterables) {
        if (el.dataset.attached == "true") {
          el.classList.add("hidden")
        }
      }
    }
  }

  const unattachedFilter = document.getElementById("filter-unattached")
  if (unattachedFilter) {
    if (unattachedFilter.checked == true) {
      for (const el of filterables) {
        if (el.dataset.attached == "false") {
          el.classList.add("hidden")
        }
      }
    }
  }

  const highFreqFilter = document.getElementById("filter-high-freq")
  if (highFreqFilter) {
    if (highFreqFilter.checked == false) {
      for (const filterable of filterables) {
        if (parseInt(filterable.dataset.frequency) > 14) {
          filterable.classList.add("hidden")
        }
      }
    }
  }

  const lowFreqFilter = document.getElementById("filter-low-freq")
  if (lowFreqFilter) {
    if (lowFreqFilter.checked == false) {
      for (const filterable of filterables) {
        if (parseInt(filterable.dataset.frequency) < 8) {
          filterable.classList.add("hidden")
        }
      }
    }
  }
  
  const visibleFilters = document.getElementsByClassName("filter-visible")
  if (visibleFilters) {
    for (const filter of visibleFilters) {
      if (filter.checked == false) {
        for (const filterable of filterables) {
          if (filter.value == filterable.dataset.visibility) {
            filterable.classList.add("hidden")
          }
        }
      }
    }
  }

  const visibleCounter = document.getElementById("available-visible-count")
  if (!visibleCounter) return
  const hiddenElems = document.getElementsByClassName("filterable hidden")
  if (hiddenElems.length == 0 ) { 
 //   visibleCounter.innerHTML = ""
  } else {
//    visibleCounter.innerHTML = filterables.length - hiddenElems.length + "/"
  }

  const totalCounter = document.getElementById("available-visible-total")
  if (!totalCounter) return
  totalCounter.innerHTML = filterables.length

}