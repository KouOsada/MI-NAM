class AddEvaluationToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :evaluation, :float
  end
end
