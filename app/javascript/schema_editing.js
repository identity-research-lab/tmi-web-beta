export function handleSchemaForms() {
  document.addEventListener("change", (event) => {
    const form = event.target.form
    if (!form) return
    if (form.matches(".survey-item-form")) {
    // form.requestSubmit()
      form.submit()
    }
  });

  document.querySelectorAll(".project-field-switch input").forEach((toggle) => {
    const status = toggle.closest(".project-field-status").querySelector(".project-field-status-text");
  
    const updateStatus = () => {
      status.textContent = toggle.checked ? "Active" : "Inactive";
      toggle.closest("tr").classList.toggle("is-inactive", !toggle.checked);
    };
  
    toggle.addEventListener("change", updateStatus);
    updateStatus();
  });

}
