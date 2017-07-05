Rails.application.routes.draw do
  get 'bookmark_station/unbookmark'

  get 'bookmark_station/bookmark'

  get 'bookmark_station/list'

  resources :station_histories
  resources :open_times
  resources :positions
  resources :stations
  get 'api/index'
  get 'api/free_slots_bikes'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root_url
  root 'api#index'

end
