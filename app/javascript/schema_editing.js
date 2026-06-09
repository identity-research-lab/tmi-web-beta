export function handleSchemaForms() {
  document.addEventListener("change", (event) => {
    console.log('ATTACHED')
    const form = event.target.closest(".survey-item-form")
    console.log(event.target)
    console.log(event.target.closest('.radio-row'))
    if (!form) return
    const submitButton = form.querySelector('input[type:"submit"]')
    submitButton.classList.remove("hidden")
  });
}
