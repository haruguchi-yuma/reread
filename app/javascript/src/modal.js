if (document.URL.match(/books\/?$/)) {
  document.addEventListener('turbolinks:load', () => {
    const $show = document.getElementById('show-modal')

    $show.addEventListener('click', () => {
      const $modal = document.getElementById('modal-window')
      $modal.classList.add('is-active')

    })

    const $close = document.getElementById('close-modal')

    $close.addEventListener('click', () => {
      const $modal = document.getElementById('modal-window')
      $modal.classList.remove('is-active')
    })

    const $background = document.getElementById('modal-background')

    $background.addEventListener('click', () => {
      const $modal = document.getElementById('modal-window')
      $modal.classList.remove('is-active')
    })

    const $closeButton = document.getElementById('close-button')

    $closeButton.addEventListener('click', () => {
      const $modal = document.getElementById('modal-window')
      $modal.classList.remove('is-active')
    })

  })
}
