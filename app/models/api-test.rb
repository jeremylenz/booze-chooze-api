require 'HTTParty'
require 'byebug'
response = HTTParty.get('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list')
ingredients = JSON.parse(response.body)
byebug
puts ingredients
