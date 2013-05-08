class Users::SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    render :json => {
        :success => true,
        :user => {
            uid: resource[:uid],
            username: resource[:username],
            email: resource[:email],
            provider: resource[:provider]
        }
    }

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

  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    cookies.delete :current_user

    return render :json => {:success => true }
  end

  def failure
    return render :json => {:success => false,
                            :errors => ["Login failed."]}
  end
end