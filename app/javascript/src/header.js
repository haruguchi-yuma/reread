document.addEventListener('turbolinks:load', () => {
  const navbarBurgers = document.querySelectorAll('.navbar-burger')

  navbarBurgers.forEach((el) => {
    el.addEventListener('click', () => {
      const target = document.getElementById(el.dataset.target)

      el.classList.toggle('is-active')
      target.classList.toggle('is-active')
    })
  })
})
