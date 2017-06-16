Rails.application.routes.draw do
  resources :open_times
  resources :positions
  resources :stations
  get 'api/index'
  get 'api/free_slots'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root_url
  root 'api#index'

end
