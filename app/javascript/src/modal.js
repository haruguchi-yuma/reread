document.addEventListener('DOMContentLoaded', () => {
  for (const element of document.querySelectorAll(
    '#show-modal, #close-modal, #modal-background, #close-button'
  )) {
    element.addEventListener('click', () => {
      const modal = document.querySelector('#modal-window')
      modal.classList.toggle('is-active')
    })
  }
})
