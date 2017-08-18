# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Ingredient list courtesy of this dope API we found

Ingredient.all.each do |ing|
  ing.destroy
end

require 'HTTParty'
require 'byebug'
response = HTTParty.get('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list')
ingredients = JSON.parse(response.body)

ingredients["drinks"].each do |ing|
  img_url = "http://www.thecocktaildb.com/images/ingredients/#{ing["strIngredient1"]}.png"
  Ingredient.create(name: ing["strIngredient1"], is_alcoholic: true, image_url: img_url)
end
