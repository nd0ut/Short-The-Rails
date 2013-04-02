class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token, :only => :create

  def vkontakte
    @user = User.find_or_create_for_vkontakte env["omniauth.auth"]
    sign_in_and_redirect @user, :event => :authentication
  end

  def github
    @user = User.find_or_create_for_github env["omniauth.auth"]
    sign_in_and_redirect @user, :event => :authentication
  end
end
