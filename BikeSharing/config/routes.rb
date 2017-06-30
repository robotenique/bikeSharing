Rails.application.routes.draw do
  get 'bookmark_station/unbookmark'

  get 'bookmark_station/bookmark'

  get 'bookmark_station/list'

  get 'bookmark_station/list_rank'

  resources :station_histories
  resources :open_times
  resources :positions
  get 'stations/free_slots/:sort', to: 'stations#free_slots', :as => :free_slots1
  get 'stations/free_slots/', to: 'stations#free_slots', :as => :free_slots
  resources :stations
  get 'api/index'
  get 'api/free_slots_bikes'


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root_url
  root 'api#index'

end
