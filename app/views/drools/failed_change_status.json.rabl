object @api_response => :response
attributes :code, :status, :details

child @drool do
attributes :id, :status
  node :errors do |model|
    model.errors.full_messages.to_a
  end
end
