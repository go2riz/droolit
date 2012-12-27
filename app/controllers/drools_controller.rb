class DroolsController < ApplicationController
  prepend_before_filter :check_auth_token
  before_filter :set_template, :only => [:create]
  before_filter :set_drool, :only => [:update, :destroy]

  respond_to :json

  def create
    @drool = Drool.new(params[:drool])
    @drool.owner = current_user
    @drool.template = @template

    if @drool.save
      set_api_response("200", "Drool has been created successfully.")
      render :template => "/drools/show"
    else
      set_api_response("422", "Failed to create drool.")
      render :template => "/drools/new"
    end

  end

  def update
    if @drool.update_attributes(params[:drool])
      set_api_response("200", "Drool has been updated successfully.")
      render :template => "/drools/show"
    else
      set_api_response("422", "Failed to update drool.")
      render :template => "/drools/new"
    end
  end

  def destroy
    if @drool.destroy
      set_api_response("200", "Drool has been deleted successfully.")
      render :template => "/drools/show"
    else
      set_api_response("422", "Failed to delete drool.")
      render :template => "/drools/new"
    end
  end

  protected

  def set_template
    @template = Template.find(params[:id]) rescue nil

    if @template.nil?
      @object = Template.new
      set_api_response("404", "Failed to find the template.")
      return(render :template => "/shared/not_found")
    elsif !current_user.is_admin && @template.owner != current_user
      @object = @template
      set_api_response("401", "Failed to authorize the template.")
      return(render :template => "/shared/not_authorized")
    end
  end

  def set_template_field
    @template_fields = @template.template_fields
    user_template_fields = params[:drool][:template_fields]
  end

  def set_drool
    @drool = Drool.find(params[:id]) rescue nil

    if @drool.nil?
      @object = Drool.new
      set_api_response("404", "Failed to find the drool.")
      return(render :template => "/shared/not_found")
    elsif @drool.owner != current_user
      @object = @drool
      set_api_response("401", "Failed to authorize the drool.")
      return(render :template => "/shared/not_authorized")
    end
  end

end
