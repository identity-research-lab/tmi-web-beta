export function copyToClipboard(elementId) {
  var element = document.getElementById(elementId)
  var textarea = document.createElement('textarea')
  var tooltip = document.getElementById('confirmation')
  var copyIcon = document.getElementById('copy-to-clipboard')

  textarea.value = element.textContent

  document.body.appendChild(textarea)
  textarea.select()
  document.execCommand('copy')
  document.body.removeChild(textarea)

  tooltip.classList.remove("hidden")
  tooltip.classList.remove("appear-disappear")

  element.classList.add("hidden")
  copyIcon.classList.add("hidden")
  
  setTimeout(function() { tooltip.classList.add("hidden") }, 1000)
  setTimeout(function() { element.classList.add("appear"); element.classList.remove("hidden"); copyIcon.classList.add("appear"); copyIcon.classList.remove("hidden") }, 1000)

}
