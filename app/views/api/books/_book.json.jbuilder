json.id book.id
json.title book.title
json.photo_updated_at last_update_of_photo(book)
json.number_of_photos book.photos.count
json.read_back_at book.read_histories.last ? l(book.read_histories.last&.read_back_at, format: :date) : ''
json.url book_path(book)
