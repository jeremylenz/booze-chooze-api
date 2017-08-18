class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.integer :cocktail_id
      t.integer :ingredient_id
      t.integer :parts

      t.timestamps
    end
  end
end
