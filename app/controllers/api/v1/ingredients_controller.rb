module Api
  module V1

class IngredientsController < ApplicationController


  before_action :set_ingredient, except: [:index, :create]

  def create
    new_ingredient = Ingredient.create(ingredient_params)

    if !new_ingredient.errors.empty?
      render json: {status: "error", code: 400, message: new_ingredient.errors.full_messages[0]}
    else
      render json: new_ingredient
    end

  end


  def update
    @ingredient.update(ingredient_params)
    render json: @ingredient
  end


  def index
    @ingredients = Ingredient.all
    render json: @ingredients
  end

  def show
    render json: @ingredient
  end



  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :is_alcoholic, :image_url)
  end

end # of class

end
end
