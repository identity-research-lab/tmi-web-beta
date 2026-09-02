export function handleAssignments() {
  const assignForms = document.getElementsByClassName("assign-form")
  for (const assignForm of assignForms) {
    assignForm.addEventListener("submit", (event) => {
      const submitButton = event.submitter
      if (!submitButton) return
      submitButton.classList.add("hidden")

      const assignedId = submitButton.dataset.assignedid
      const assignedIcons = document.getElementsByClassName("assigned-icon")
      
      for (const assignedIcon of assignedIcons) {
        if (assignedIcon.dataset.assignedid == assignedId) {
          assignedIcon.classList.remove("hidden")
        }
      }
    })
  }
}
