<template>
  <div>
    <div v-if="this.books.length == 0" class="blank-page has-text-centered has-text-grey" >
      <div class="o-empty-message__text">
          書籍はまだありません
      </div>
      <div class="is-size-1">
        <i class="far fa-sad-tear"></i>
      </div>
    </div>
    <div v-else>
      <table class="table is-fullwidth">
        <thead>
          <tr>
            <td class="has-text-weight-bold">書籍名</td>
            <td class="has-text-weight-bold">最終投稿日</td>
            <td class="has-text-weight-bold">読み返す日</td>
          </tr>
        </thead>
        <tbody>
          <tr v-for="book in books" :key="book.id">
            <td class="is-size-5">
              <a :href="book.url" class="is-block">
                {{ book.title }}
                <span class="photo-count ml-4">{{ book.number_of_photos }}</span>
              </a>
            </td>
            <td>
              {{ book.photo_updated_at }}
            </td>
            <td>
              {{ book.read_back_at }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import axios from 'axios'


export default {
  data() {
    return {
      books: ''
    }
  },
  methods: {
    setBook() {
      axios
        .get('/api/books')
        .then(response => this.books = response.data.books)
    }
  },
  mounted() {
    this.setBook()
  }
}
</script>
