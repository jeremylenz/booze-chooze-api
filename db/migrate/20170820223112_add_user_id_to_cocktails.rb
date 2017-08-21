class AddUserIdToCocktails < ActiveRecord::Migration[5.1]
  def change
    add_column :cocktails, :user_id, :integer
  end
end
