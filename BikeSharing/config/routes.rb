Rails.application.routes.draw do
  get 'api/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root_url
  root 'api#index'

end
