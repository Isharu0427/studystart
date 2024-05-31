class ChangeDatatypeImageOfBooks < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :image, :string
  end
end
