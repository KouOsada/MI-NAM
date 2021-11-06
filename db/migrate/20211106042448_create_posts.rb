class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :post_image_id, null: false

      t.timestamps
    end
  end
end
