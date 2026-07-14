export function handleSurveyItemSelect() {
  document.addEventListener("change", (event) => {
    const form = event.target.form
    if (!form) return
    if (form.matches("#survey-item-select")) { form.requestSubmit() }
  });
}

export function sortCodes(index) {

  const list = document.getElementById("frequency-list")
  if (!list) return

  const rows = Array.from(list.getElementsByClassName("frequency-row"))
  const controls = Array.from(document.getElementsByClassName("sortable"))
  const sortDirection = controls[index].dataset.sortDirection

  controls.forEach(function(control) {
    control.classList.remove("sort-asc")
    control.classList.remove("sort-desc")
  })

  // toggle
  if (sortDirection == "asc") {
    controls[index].dataset.sortDirection = "desc"
    controls[index].classList.add("sort-asc")
    controls[index].classList.remove("sort-desc")
  } else {
    controls[index].dataset.sortDirection = "asc"
    controls[index].classList.add("sort-desc")
    controls[index].classList.remove("sort-asc")
  }

  rows.sort(function(a,b) {
    var valueA
    var valueB

    if (index == 1) {
      valueA = a.dataset.sortAlpha
      valueB = b.dataset.sortAlpha
    } else {
      valueA = a.dataset.sortFrequency
      valueB = b.dataset.sortFrequency
    }

    const numA = Number(valueA)
    const numB = Number(valueB)
    const isNumericSort = !Number.isNaN(numA) && !Number.isNaN(numB)

    console.log(valueA)
    console.log(isNumericSort)

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
  }).forEach(div => list.appendChild(div))

}
