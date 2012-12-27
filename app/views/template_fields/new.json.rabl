object @api_response => :response
attributes :code, :status, :details

child @template_field do
attributes :label, :required, :display_message, :hint, :datatype, :max_length, :default_value, :display_order, :status
  node :errors do |model|
    model.errors.full_messages.to_a
  end
end
