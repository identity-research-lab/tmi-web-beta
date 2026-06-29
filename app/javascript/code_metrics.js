export function handleSurveyItemSelect() {
  document.addEventListener("change", (event) => {
    const form = event.target.form
    if (!form) return
    if (form.matches("#survey-item-select")) { form.requestSubmit() }
  });
}
