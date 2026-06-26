export function sortTable(columnIndex) {

  const table = document.getElementById("data-table")
  if (!table) return

  const tbody = table.getElementsByTagName("tbody")[0]
  var rows = Array.from(tbody.rows)

  rows.sort(function(a,b) {
    const valueA = a.cells[columnIndex]?.dataset.sortIndex
    const valueB = b.cells[columnIndex]?.dataset.sortIndex

    const numA = Number(valueA)
    const numB = Number(valueB)
    const isNumericSort = !Number.isNaN(numA) && !Number.isNaN(numB)

    if (isNumericSort) {
      return numB - numA
    } else {
      return valueB.localeCompare(valueA)
    }
  }).forEach(tr => tbody.appendChild(tr))

}
