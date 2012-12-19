object @api_response => :response
attributes :code, :status, :details

child @user do
attributes :authentication_token
  node :errors do |model|
    model.errors.full_messages.to_a
  end
end
