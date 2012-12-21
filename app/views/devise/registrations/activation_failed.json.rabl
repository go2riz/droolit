object @api_response => :response
attributes :code, :status, :details

child resource do
  node :errors do |model|
    errors = []

    if params[:token].blank?
      errors << "Activation token can't be blank."
    elsif resource.new_record?
      errors << "Invalid activation token."
    else
      errors << "Your account is not disabled."
    end

    errors
  end
end
