class AddNoteToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :note, :text
  end
end
