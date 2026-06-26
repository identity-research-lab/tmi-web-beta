export function sortTable(columnIndex) {

  const table = document.getElementById("data-table")
  if (!table) return

  const tbody = table.getElementsByTagName("tbody")[0]
  const rows = Array.from(tbody.rows)
  const theaders = Array.from(table.getElementsByTagName("th"))
  const sortDirection = theaders[columnIndex].dataset.sortDirection

  theaders.forEach(function(th) {
    th.classList.remove("sort-asc")
    th.classList.remove("sort-desc")
  })

  // toggle
  if (sortDirection == "desc") {
    theaders[columnIndex].dataset.sortDirection = "asc"
    theaders[columnIndex].classList.add("sort-asc")
    theaders[columnIndex].classList.remove("sort-desc")
  } else {
    theaders[columnIndex].dataset.sortDirection = "desc"
    theaders[columnIndex].classList.add("sort-desc")
    theaders[columnIndex].classList.remove("sort-asc")
  }

  rows.sort(function(a,b) {
    const valueA = a.cells[columnIndex]?.dataset.sortIndex
    const valueB = b.cells[columnIndex]?.dataset.sortIndex

    const numA = Number(valueA)
    const numB = Number(valueB)
    const isNumericSort = !Number.isNaN(numA) && !Number.isNaN(numB)

    if (isNumericSort) {
      if (sortDirection == "desc") {
        return numB - numA
      } else {
        return numA - numB
      }
    } else {
      if (sortDirection == "desc") {
        return valueB.localeCompare(valueA)
      } else {
        return valueA.localeCompare(valueB)
      }
    }
  }).forEach(tr => tbody.appendChild(tr))

}
