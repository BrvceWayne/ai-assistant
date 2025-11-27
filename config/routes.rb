Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :games, only: [:create, :show, :index, :destroy] do
    collection do
      get :scenarios        # ou select_scenario selon ton code
      get :characters       # ou select_character selon ton code
    end

    member do
      post :player_action
    end
  end
end
