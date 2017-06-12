class RemovePostBodyNullConstraint2 < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :body, :text, null: true
  end
end
