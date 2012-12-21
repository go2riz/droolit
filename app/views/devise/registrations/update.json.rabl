object @api_response => :response
attributes :code, :status, :details

child @user do
attributes :id, :droolit_alias, :email
  node :errors do |model|
    model.errors.full_messages.to_a
  end
end
