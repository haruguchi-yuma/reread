class RenameReadBackAtColumnToReadHistories < ActiveRecord::Migration[7.0]
  def change
    rename_column :read_histories, :read_back_at, :read_back_on
  end
end
