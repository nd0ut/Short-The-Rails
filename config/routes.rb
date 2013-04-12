ShortTheRails::Application.routes.draw do  # get "home/index"
  if Rails.env.development?
    require 'genghis'
    mount Genghis::Server.new, :at => '/db'
  end

  root :to => 'home#index'

  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks",
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  resources :urls, :only => [:index, :destroy]

  post '/short' => 'urls#short'
  get '/:code' => 'urls#unshort', :url => /.*/
end
