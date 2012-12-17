class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end
  
  def create
    respond_with do |format|
      format.json {
        build_resource

        if resource.save
          set_api_response("200", "User has been registered successfully.")
          render :template => '/devise/registrations/signed_up'
        else
          set_api_response("422", "Failed to register user.")
          render :template => '/devise/registrations/new'
        end
      }

      format.any{super}
    end
  end

end
