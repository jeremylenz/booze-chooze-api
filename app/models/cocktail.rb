class Cocktail < ApplicationRecord
  belongs_to :user
  has_many :recipes
  has_many :ingredients, through: :recipes
  accepts_nested_attributes_for :user

end
