object @api_response => :response
attributes :code, :status, :details

child @template do
attributes :id, :description, :status

child(@template.template_fields){
    collection @template.template_fields

    extends "template_fields/show"
}

end
