class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.text :image_data, null: false
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
