export function handleSchemaForms() {
  document.addEventListener("change", (event) => {
    const form = event.target.form
    if (!form) return
    
    if (form.matches(".survey-item-form")) {

      document.querySelectorAll('.has-changes').forEach((elem) => {
        elem.classList.add("hidden")
      })
    
      document.querySelectorAll('.changes-pending').forEach((elem) => {
        elem.classList.remove("hidden")
      })

      document.querySelectorAll('.changes-applied').forEach((elem) => {
        elem.classList.add("hidden")
      })
    // form.requestSubmit()
      form.submit()
    }
  });

  document.querySelectorAll(".project-field-switch input").forEach((toggle) => {
    const status = toggle.closest(".project-field-status").querySelector(".project-field-status-text")
  
    const updateStatus = () => {
      status.textContent = toggle.checked ? "Visible" : "Hidden"
      toggle.closest("tr").classList.toggle("is-inactive", !toggle.checked)
    }
  
    toggle.addEventListener("change", updateStatus)
    updateStatus()
  })

}
