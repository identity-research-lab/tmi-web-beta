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
}

export function fireFilters() {
  console.log(1)
  const elements = document.getElementsByClassName("filterable")
  for (const el of elements) {
    el.classList.remove("hidden")
  }
  const countFilter = document.getElementById("filter-count")
  if (countFilter) {
    for (const el of elements) {
      if (countFilter.checked == true) {
        if (el.dataset.count != "0") {
          el.classList.add("hidden")
        }
      }
    }
  }

}