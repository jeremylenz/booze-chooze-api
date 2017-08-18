class CreateCocktails < ActiveRecord::Migration[5.1]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.boolean :is_alcoholic, default: true 
      t.string :image_url

      t.timestamps
    end
  end
end
