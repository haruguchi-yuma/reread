import Vue from 'vue'
// import * as Vue from 'vue'
import Books from './book-index.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-books'
  const books = document.querySelector(selector)
  if (books) {
    new Vue({
      render: (h) => h(Books)
    }).$mount(selector)
    // Vue.createApp(Hello).mount(selector)
  }
})
