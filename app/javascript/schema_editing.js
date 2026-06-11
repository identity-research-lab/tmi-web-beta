export function handleSchemaForms() {
  document.addEventListener("change", (event) => {
    const form = event.target.form
    if (!form) return
    event.target.blur()
    form.requestSubmit()
  });
}
