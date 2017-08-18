class API::V1::CocktailsController < ApplicationController

  before_action :set_cocktail, except: [:index, :create]

  def create

    # Here we will go to our datamuse API and get an awesome cocktail name based on the ingredients

    new_cocktail = Cocktail.create(cocktail_params)  # this will need to be changed

    if !new_cocktail.errors.empty?
      render json: {status: "error", code: 400, message: new_cocktail.errors.full_messages[0]}, status: 400
    else
      render json: new_cocktail
    end

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
    render json: @cocktail
  end


  def destroy
    if @cocktail.destroy
      render json: {status: "OK", code: 200, message: "Cocktail has been destroyed (with extreme prejudice)"}
    else
      render json: {status: "error", code: 500, message: "Couldn't destroy cocktail  ¯\\_(ツ)_/¯"}, status: 500
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:user).permit(:name, :is_alcoholic, :image_url)
  end


end
