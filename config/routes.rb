Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :ingredients, only: [:index, :create, :update]
      post 'cocktails/generate', to: 'cocktails#generate'
      resources :cocktails, except: [:new, :edit] #Full CRUD!!!
      resources :users, except: [:new, :edit]
      resources :recipes, except: [:new, :edit]

    end

  end
end
