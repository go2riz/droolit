object @api_response => :response
attributes :code, :status, :details

child(@users){
  collection @users

  extends "users/show"
}