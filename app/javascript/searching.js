export function highlightSearchTerm(substring) {
  const highlightText = (substring) => {
    if (!substring) return;
    const elements = document.getElementsByClassName("search-result");
    const regex = new RegExp(`(${substring})`, "gi");
    for (const el of elements) {
      el.innerHTML = el.textContent.replace(
        regex,
        '<span class="highlight">$1</span>'
      );
    }
  }
}
