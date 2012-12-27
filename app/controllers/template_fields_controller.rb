class TemplateFieldsController < ApplicationController
  
  prepend_before_filter :check_auth_token
  before_filter :set_template,        :only => [:create]
  before_filter :set_template_field,  :only => [:update, :destroy]

  respond_to :json

  def create
    @template_field = TemplateField.new(params[:template_field])
    @template_field.owner = current_user
    @template_field.template = @template

    if @template_field.save
      set_api_response("200", "Template field has been created successfully.")
      render :template => "/template_fields/saved"
    else
      set_api_response("422", "Failed to create template field.")
      render :template => "/template_fields/new"
    end
  end

  def update
    if @template_field.update_attributes(params[:template_field])
      set_api_response("200", "Template field has been updated successfully.")
      render :template => "/template_fields/saved"
    else
      set_api_response("422", "Failed to update template field.")
      render :template => "/template_fields/new"
    end
  end

  def destroy
    if @template_field.destroy
      set_api_response("200", "Template field has been deleted successfully.")
      render :template => "/template_fields/saved"
    else
      set_api_response("422", "Failed to delete template field.")
      render :template => "/template_fields/new"
    end
  end

  protected

  def set_template
    @template = Template.find(params[:template_id]) rescue nil

    if @template.nil?
      @object = TemplateField.new
      set_api_response("404", "Failed to find the template.")
      return(render :template => "/shared/not_found")
    elsif !current_user.is_admin && @template.owner != current_user
      @object = @template
      set_api_response("401", "Failed to authorize the template.")
      return(render :template => "/shared/not_authorized")
    end
  end

  def set_template_field
    @template_field = TemplateField.find(params[:id]) rescue nil

    if @template_field.nil?
      @object = TemplateField.new
      set_api_response("404", "Failed to find the template field.")
      return(render :template => "/shared/not_found")
    elsif !current_user.is_admin && @template_field.owner != current_user
      @object = @template_field
      set_api_response("401", "Failed to authorize the template field.")
      return(render :template => "/shared/not_authorized")
    end
  end

end
