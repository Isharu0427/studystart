class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :user_id
      t.string :image
      t.string :genre

      t.timestamps
    end
  end
end
