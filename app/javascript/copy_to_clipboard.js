export function copyToClipboard(elementId) {
  var element = document.getElementById(elementId)
  var textarea = document.createElement('textarea')
  var tooltip = document.getElementById('confirmation')
  var content = element.textContent

  // Strip last character to avoid copying clipboard icon
  textarea.value = content.substring(0, content.length - 1)

  document.body.appendChild(textarea)
  textarea.select()
  document.execCommand('copy')
  document.body.removeChild(textarea)

  tooltip.classList.add("hidden")
  tooltip.classList.remove("appear-disappear")

  setTimeout(function() { tooltip.classList.remove("hidden") }, 200)

  tooltip.classList.add("appear-disappear")
}
