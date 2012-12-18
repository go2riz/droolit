class ConfirmationsController < Devise::ConfirmationsController

  def new
    super
  end

  def create
    super
  end

  def show

    respond_with do |format|
     format.json {
       self.resource = resource_class.confirm_by_token(params[:confirmation_token])

       if resource.errors.empty?
         set_api_response("200", "User has been confirmed successfully.")
         render :template => '/devise/confirmations/confirmed'
       else
         set_api_response("422", "Failed to confirm user.")
         render :template => '/devise/confirmations/new'
       end
    }

    format.any{super}
    end

  end

end
