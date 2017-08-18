class Ingredient < ApplicationRecord
  has_many :recipes
  has_many :cocktails, through: :recipes
end
