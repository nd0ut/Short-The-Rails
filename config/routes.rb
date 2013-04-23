ShortTheRails::Application.routes.draw do  # get "home/index"
  root :to => 'home#index'

  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks",
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  resources :urls, :only => [:index, :create, :destroy]
  get '/urls/:code' => 'urls#show', :url => /.*/


  post '/short' => 'urls#short'
  get '/:code' => 'urls#unshort', :url => /.*/
end
