export function highlightSearchTerm() {
  const searchbox = document.getElementById("search-query")
  if (!searchbox) return
  const substring = searchbox.value
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

export function handleSearchFilters() {
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
  const visibleFilters = document.getElementsByClassName("filter-visible")
  if (visibleFilters) {
    for (const el of visibleFilters) {
      el.addEventListener("change", (event) => {
        fireFilters()
      })
    }
  }
}

export function fireFilters() {
  const filterables = document.getElementsByClassName("filterable")
  for (const el of filterables) {
    el.classList.remove("hidden")
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

  const visibleFilters = document.getElementsByClassName("filter-visible")
  if (visibleFilters) {
    for (const filter of visibleFilters) {
      if (filter.checked == false) {
        for (const filterable of filterables) {
          console.log(filter.value + " == " + filterable.dataset.filter)
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
    visibleCounter.innerHTML = ""
  } else {
    visibleCounter.innerHTML = filterables.length - hiddenElems.length + "/"
  }

}