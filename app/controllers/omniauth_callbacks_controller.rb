class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.find_or_create_for_vkontakte env["omniauth.auth"]
    flash[:notice] = "succeed with vk"
    sign_in_and_redirect @user, :event => :authentication
  end
end
