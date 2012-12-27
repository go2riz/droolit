object @api_response => :response
attributes :code, :status, :details

child @template_field do |template_field|
  extends "template_fields/show"
end
