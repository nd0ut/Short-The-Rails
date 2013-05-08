class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token, :only => :create

  def vkontakte
    @user = User.find_or_create_for_vkontakte env["omniauth.auth"]
    sign_in_and_redirect @user, :event => :authentication
  end

  def github
    @user = User.find_or_create_for_github env["omniauth.auth"]
    sign_in_and_redirect @user, :event => :authentication
  end

  def twitter
    @user = User.find_or_create_for_twitter env["omniauth.auth"]
    sign_in_and_redirect @user, :event => :authentication
  end

  def sign_in_and_redirect(resource_or_scope, *args)
    options = args.extract_options!
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource = args.last || resource_or_scope
    sign_in(scope, resource, options)
    redirect_to after_sign_in_path_for(resource)

    require "base64"
    cookies[:current_user] = {
        :value => Base64.encode64(
            {
                uid: current_user[:uid],
                username: current_user[:username],
                email: current_user[:email],
                provider: current_user[:provider],
            }.to_json
        )
    }
  end

end
