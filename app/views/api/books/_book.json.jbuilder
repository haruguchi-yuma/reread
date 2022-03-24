json.title book.title
json.photo_updated_at last_update_of_photo(book)
json.read_back_at book.read_histories.last&.read_back_at
