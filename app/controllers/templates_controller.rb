class TemplatesController < ApplicationController
  
  prepend_before_filter :check_auth_token
  before_filter :set_template, :only => [:show, :update, :destroy]
  
  respond_to :json
  
  def create
    @template = Template.new(params[:template])

    if @template.save
      set_api_response("200", "Template has been created successfully.")
      render :template => "/templates/show"
    else
      set_api_response("422", "Failed to create template.")
      render :template => "/templates/new"
    end

  end

  def show
    set_api_response("200", "Template details.")
    render :template => "/templates/show"
  end

  def update
    template_params = {:description => params[:template][:description], :status => params[:template][:status]}

    if @template.update_attributes(template_params)
      set_api_response("200", "Template has been updated successfully.")
      render :template => "/templates/show"
    else
      set_api_response("422", "Failed to update template.")
      render :template => "/templates/new"
    end
  end
  
  def destroy
    if @template.destroy
      set_api_response("200", "Template has been deleted successfully.")
      render :template => "/templates/show"
    else
      set_api_response("422", "Failed to delete template.")
      render :template => "/templates/new"
    end
  end
  
  protected
  
  def set_template
    @template = Template.find(params[:id]) rescue nil

    if @template.nil?
      @object = Template.new
      set_api_response("404", "Failed to find template.")
      return(render :template => "/shared/not_found")
    end
  end
  
end
