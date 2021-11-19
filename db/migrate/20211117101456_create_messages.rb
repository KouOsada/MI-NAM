class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :room_id, null: false
      t.integer :user_id, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
