# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'HTTParty'
require 'byebug'
response = HTTParty.get('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list')
ingredients = JSON.parse(response.body)

NON_ALCOHOLIC_INGREDIENTS = ["Sugar", "Ice", "Lemon", "Lime juice", "Egg", "Mint", "Sweet and sour", "Salt", "Carbonated water", "Lemon peel", "Grenadine", "Grapefruit juice", "Vanilla ice-cream", "Lime juice cordial", "Apple juice", "Berries", "Blueberries", "Orange juice", "Cranberries", "Brown sugar", "Milk", "Mango", "Egg yolk", "Lemon juice", "Soda water", "Cream", "Pineapple", "Sugar syrup", "Ginger ale", "Worcestershire sauce", "Ginger", "Strawberries", "Chocolate syrup", "Yoghurt", "Grape juice", "Orange", "Apple cider", "Banana", "Soy milk", "Lime", "Cantaloupe", "Grapes", "Kiwi", "Tomato juice", "Cocoa powder", "Chocolate", "Heavy cream", "Coffee", "Water", "Espresso", "Honey", "Whipping cream", "Half-and-half", "Bread", "Plums", "Vanilla", "Apple", "Kool-Aid", "Lemonade", "Cranberry juice", "Eggnog", "Carbonated soft drink", "Cloves", "Raisins", "Almond", "Pink lemonade", "Sherbet", "Peach nectar", "Coca-Cola", "Tang", "Cider", "7-Up", "Limeade", "Maraschino cherry juice", "Cardamom", "Tabasco sauce", "Fruit punch", "Cherry juice", "Orange peel", "Clamato juice", "Sour mix", "Root beer", "Hot chocolate", "Jello", "Mountain Dew", "Cream of coconut", "Fruit juice", "Chocolate ice-cream", "Hawaiian Punch", "Tea", "demerara Sugar", "Passion fruit juice", "Pineapple juice", "Angelica root", "Condensed milk", "Tropicana", "Sprite", "Chocolate milk", "Beef bouillon", "Dr. Pepper", "Iced tea", "Club soda", "Cherry Cola", "Orange soda", "Lemon-lime soda", "Schweppes Russchian", "coconut milk"]

# def guess_alcohol_content(ing_name)
#   is_alcoholic = false
#   alcohol_indicators = ["rum", "vermouth", "schnapps", "scotch", "brandy", "whiskey", "whisky", "blanc", "champagne", "liqueur", "cachaca", "brandy", "sherry", "shartreuse", "cognac", "jack", "sake", "creme", "cuervo", "tequila", "gin", "wine", "sambuca", "bacardi", "bailey's"]
#   alcohol_indicators.each do |alcohol|
#     if ing_name.downcase.include(alcohol)
#       is_alcoholic = true
#     end
#   is_alcoholic
# end




# Ingredient list thanks to cocktaildb API

Ingredient.all.each do |ing|
  ing.destroy
end


ingredients["drinks"].each do |ing|
  ing_name = ing["strIngredient1"]
  img_url = "http://www.thecocktaildb.com/images/ingredients/#{ing_name}.png"
  Ingredient.create(name: ing_name, is_alcoholic: !NON_ALCOHOLIC_INGREDIENTS.include?(ing_name), image_url: img_url)
end

puts "Database seeded with #{Ingredient.all.length} ingredients"

User.create(name: "JerBear")

#non-alcoholic drinks array:

# ["Sugar", "Ice", "Lemon", "Lime juice", "Egg", "Mint", "Sweet and sour", "Salt", "Carbonated water", "Lemon peel", "Grenadine", "Grapefruit juice", "Vanilla ice-cream", "Lime juice cordial", "Apple juice", "Berries", "Blueberries", "Orange juice", "Cranberries", "Brown sugar", "Milk", "Mango", "Egg yolk", "Lemon juice", "Soda water", "Cream", "Pineapple", "Sugar syrup", "Ginger ale", "Worcestershire sauce", "Ginger", "Strawberries", "Chocolate syrup", "Yoghurt", "Grape juice", "Orange", "Apple cider", "Banana", "Soy milk", "Lime", "Cantaloupe", "Grapes", "Kiwi", "Tomato juice", "Cocoa powder", "Chocolate", "Heavy cream", "Coffee", "Water", "Espresso", "Honey", "Whipping cream", "Half-and-half", "Bread", "Plums", "Vanilla", "Apple", "Kool-Aid", "Lemonade", "Cranberry juice", "Eggnog", "Carbonated soft drink", "Cloves", "Raisins", "Almond", "Pink lemonade", "Sherbet", "Peach nectar", "Coca-Cola", "Tang", "Cider", "7-Up", "Limeade", "Maraschino cherry juice", "Cardamom", "Tabasco sauce", "Fruit punch", "Cherry juice", "Orange peel", "Clamato juice", "Sour mix", "Root beer", "Hot chocolate", "Jello", "Mountain Dew", "Cream of coconut", "Fruit juice", "Chocolate ice-cream", "Hawaiian Punch", "Tea", "demerara Sugar", "Passion fruit juice", "Pineapple juice", "Angelica root", "Condensed milk", "Tropicana", "Sprite", "Chocolate milk", "Beef bouillon", "Dr. Pepper", "Iced tea", "Club soda", "Cherry Cola", "Orange soda", "Lemon-lime soda", "Schweppes Russchian", "coconut milk"]

#non-alcoholic drink indexes

# [27, 30, 31, 38, 39, 40, 53, 54, 59, 60, 69, 73, 76, 79, 83, 84, 85, 86, 88, 89, 90, 108, 91, 92, 93, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 109, 110, 111, 112, 113, 114, 115, 116, 117, 120, 122, 123, 126, 127, 128, 129, 130, 132, 133, 136, 137, 138, 139, 140, 141, 142, 143, 145, 146, 147, 179, 181, 185, 192, 193, 198, 202, 204, 208, 210, 212, 214, 215, 223, 228, 229, 230, 235, 237, 241, 244, 17, 47, 66, 87, 124, 125, 182, 187, 246, 248, 249, 250, 252, 256, 261, 263, 266, 270]
