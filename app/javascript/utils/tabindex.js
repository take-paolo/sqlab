export function addTabIndexTo(selectors, node) {
  const elements = node.querySelectorAll(selectors)
  elements.forEach(el => {
    if (!el.hasAttribute('tabIndex')) {
      el.tabIndex = 0
    }
  })
}
