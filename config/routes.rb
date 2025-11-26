Rails.application.routes.draw do
  get 'scenarios/index'
  get 'scenarios/view'
  devise_for :users
  root to: "pages#home"
  resources :games, only: [:show, :create] do
    collection do
      get :scenarios
      get :characters
    end
  end
end
