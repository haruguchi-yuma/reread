class CreateReadHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :read_histories do |t|
      t.string :summary, null: false
      t.text :description
      t.date :read_back_at, null: false
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
