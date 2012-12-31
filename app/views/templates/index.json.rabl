object @api_response => :response
attributes :code, :status, :details

child(@templates){
  collection @templates

  extends "templates/record"
}