class AddScoreToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :score, :decimal, precision: 5, scale: 3
  end
end
