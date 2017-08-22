class Api::V1::CocktailsController < ApplicationController

  before_action :set_cocktail, except: [:index, :create, :generate]

  def create

    user = User.find(params[:user][:id])

    new_cocktail = Cocktail.new(cocktail_params)
    new_cocktail.user = user
    new_cocktail.save

    if !new_cocktail.errors.empty?
      render json: {status: "error", code: 400, message: new_cocktail.errors.full_messages[0]}, status: 400
    else
      render json: new_cocktail
    end
  end

  def generate
    new_cocktail_name =  generate_cocktail_name(params[:recipe])
    render json: {name: new_cocktail_name}
  end


  def update
    @cocktail.update(cocktail_params)
    render json: @cocktail
  end


  def index
    @cocktails = Cocktail.all
    render json: @cocktails
  end

  def show
    render json: {cocktail: @cocktail,
      recipes: @cocktail.recipes
    }
  end


  def destroy
    if @cocktail.destroy
      render json: {status: "OK", code: 200, message: "Cocktail has been destroyed (with extreme prejudice)"}
    else
      render json: {status: "error", code: 500, message: "Couldn't destroy cocktail  ¯\\_(ツ)_/¯"}, status: 500
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :is_alcoholic, :image_url)
  end

  def generate_cocktail_name(data)
    # data = {ingredient1: 2,
  #        ingredient2: 2}

    name_words = data.keys.map do |ingredient|
      response = HTTParty.get("https://api.datamuse.com/words?rel_jjb=#{ingredient.split(" ").last}&topics=alcohol")
      !response.empty? ? response[rand(result_length(response.length))]["word"].capitalize : nil
    end.compact
    response_b = HTTParty.get("https://api.datamuse.com/words?rel_jja=#{data.keys.last.split(" ").last}&topics=alcohol")
    if !response_b.empty?
      name_words.pop
      name_words.push(response_b[rand(result_length(response_b.length))]["word"].capitalize.singularize)
    else
      name_words << "thing".capitalize
    end
      name_words.join(" ")

  end

  def result_length(lng)
    if lng < 10
      return lng
    else
      return (lng / 3).to_i
    end

  end

end
