export function handleSchemaForms() {
  document.addEventListener("change", (event) => {
    const form = event.target.form
    if (!form) return
    form.requestSubmit()
  });
}
