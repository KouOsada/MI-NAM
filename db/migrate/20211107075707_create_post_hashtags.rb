class CreatePostHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_hashtags do |t|
      t.integer :post_id
      t.integer :hashtag_id

      t.timestamps
    end
  end
end
