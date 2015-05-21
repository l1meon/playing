Rails.application.routes.draw do
  resources :games
  devise_for :users
  resources :tables do
    member do
      post :place_bet
      get :play_game
      patch :clear_players, as: :clean
    end
  end
  root 'tables#index'
end
