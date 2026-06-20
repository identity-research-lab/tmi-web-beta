export function handleSchemaForms() {
  document.addEventListener("change", (event) => {
    const form = event.target.form
    if (!form) return
    if (form.matches(".survey-item-form")) {
    // form.requestSubmit()
      form.submit()
    }
  });
}
