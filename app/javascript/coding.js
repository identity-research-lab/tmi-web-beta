export function handleCodingForms() {
  document.addEventListener("keydown", (event) => {
    if (event.key !== "enter") return
    
    const form = event.target.form
    if (!form) return
    form.requestSubmit()
  });
  
  document.addEventListener("turbo:frame-render", (event) => {
    const frame = event.target
    const input = frame.querySelector("input[type='text'], textarea")
  
    if (input) {
      input.focus()
    }
  })

}
