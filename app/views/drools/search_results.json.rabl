object @api_response => :response
attributes :code, :status, :details

child(@drools){
  collection @drools

  extends "drools/search_item"
}