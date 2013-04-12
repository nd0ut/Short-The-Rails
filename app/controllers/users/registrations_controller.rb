class Users::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end


  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        return render :partial => "/navbar", :layout => false
      end
    else
      clean_up_passwords resource
      return render :json => {:success => false,
                              :errors => resource.errors }
    end
  end

  def update
    super
  end
end 