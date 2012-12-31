object @template
attributes :id, :description, :status

child(:template_fields) do |template_fields|

  extends "template_fields/show"
end
