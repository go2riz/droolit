object @api_response => :response
attributes :code, :status, :details

child resource do
  node :errors do |model|
    model.errors.full_messages.to_a
  end
end