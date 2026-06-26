export function sortTable(columnIndex) {

  const table = document.getElementById("data-table")
  if (!table) return

  const tbody = table.getElementsByTagName("tbody")[0]
  var rows = Array.from(tbody.rows)

  rows.sort(function(a,b) {
    const valueA = Number(a.cells[columnIndex]?.dataset.sort ?? 0)
    const valueB = Number(b.cells[columnIndex]?.dataset.sort ?? 0)
    return valueB - valueA
  }).forEach(tr => tbody.appendChild(tr))

}
