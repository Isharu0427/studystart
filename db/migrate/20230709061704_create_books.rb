class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :publisher
      t.string :genre
      t.text :about
      t.integer :user_id
      t.integer :image
      t.date :date_publication
      t.string :grade

      t.timestamps
    end
  end
end
