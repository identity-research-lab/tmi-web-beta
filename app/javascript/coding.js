export function handleCodingForms() {
  document.addEventListener("keydown", (event) => {
    if (event.key !== "enter") return
    
    const form = event.target.form
    if (!form) return
    form.requestSubmit()
  });
}
