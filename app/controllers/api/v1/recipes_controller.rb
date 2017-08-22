class Api::V1::RecipesController < ApplicationController

  before_action :set_recipe, except: [:index, :create, :bulkcreate]

  def create
    new_recipe = Recipe.create(recipe_params)

    if !new_recipe.errors.empty?
      render json: {status: "error", code: 400, message: new_recipe.errors.full_messages[0]}
    else
      render_nice_recipe(new_recipe)

    end

  end

  def bulkcreate

    recipes_to_create = recipe_params[:bulk]
    resp = recipes_to_create.each_with_object([]) do |recipe, resp|
      new_recipe = Recipe.create(recipe)
      if new_recipe.errors.empty?
        resp << "Created recipe with id ##{new_recipe.id}"
      else
        resp << new_recipe.errors.full_messages[0]
      end

    end

    render json: {response: resp}

  end


  def update
    @recipe.update(recipe_params)
    render json: @recipe
  end


  def index
    @recipes = Recipe.all
    render json: @recipes
  end


  def destroy
    if @recipe.destroy
      render json: {status: "OK", code: 200, message: "Recipe has been destroyed (because it sucked)"}
    else
      render json: {status: "error", code: 500, message: "Couldn't destroy recipe  ¯\\_(ツ)_/¯"}, status: 500
    end
  end

  def show
    render_nice_recipe(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:cocktail_id, :ingredient_id, :parts, bulk: [:cocktail_id, :ingredient_id, :parts])
  end

  def render_nice_recipe(new_recipe)
    ingredient_name = Ingredient.find(new_recipe.ingredient_id).name
    parts_text = "#{new_recipe.parts} parts"
    recipe_line_item_text = "#{parts_text} #{ingredient_name}"
    render json: {id: new_recipe.id,
                cocktail_id: new_recipe.cocktail_id,
                "Cocktail name:" => "#{Cocktail.find(new_recipe.cocktail_id).name}",
                ingredient_id: new_recipe.ingredient_id,
                "Ingredient name:" => "#{ingredient_name}",
                parts: new_recipe.parts,
                parts_text: parts_text,
                recipe_line_item_text: recipe_line_item_text}
  end

end # of class
