document.addEventListener('turbolinks:load', () => {
  if (document.querySelector('#new-image')) {
    const createImageHTML = (blob) => {
      const imageElement = document.querySelector('#new-image')
      const blobImage = document.createElement('img')
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob)

      imageElement.appendChild(blobImage)
    }

    document.querySelector('#photo_image').addEventListener('change', (e) => {
      const imageContent = document.querySelector('.new-img')
      if (imageContent) imageContent.remove()

      const file = e.target.files[0]
      const blob = window.URL.createObjectURL(file)
      createImageHTML(blob)
    })
  }
})
