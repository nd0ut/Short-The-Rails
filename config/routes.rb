ShortTheRails::Application.routes.draw do  # get "home/index"
  root :to => 'home#index'

  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks"}
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :urls

  post '/short' => 'urls#short'
  get '/:code' => 'urls#unshort', :url => /.*/
end
