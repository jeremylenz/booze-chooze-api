class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.boolean :is_alcoholic
      t.string :image_url

      t.timestamps
    end
  end
end
