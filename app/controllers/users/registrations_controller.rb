class Users::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        return render :json => {
            :success => true,
            :user => {
                uid: resource[:uid],
                username: resource[:username],
                email: resource[:email],
                provider: resource[:provider]
            }
        }
      end
    else
      clean_up_passwords resource
      return render :json => {:success => false,
                              :errors => resource.errors }
    end
  end

end 