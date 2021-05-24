Rails.application.routes.draw do

  root controller: :rooms, action: :index
  resources :room_messages
  resources :rooms
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'video#home'
  # get '/login', to: 'video#login'
  get '/party', to: 'video#party'
  get '/screenshare', to: 'video#screenshare'
  
  post '/login', to: 'video#login'
  # post 'chat/send', to: 'video#chat'
end
