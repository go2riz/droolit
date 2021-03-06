class DroolsController < ApplicationController
  prepend_before_filter :check_auth_token
  before_filter :set_template, :only => [:create]
  before_filter :set_drool, :only => [:update, :destroy, :change_status]
  before_filter :check_drool_template_field, :only => [:create]

  respond_to :json

  def create
    @drool = Drool.new(params[:drool])
    @drool.owner = current_user
    @drool.template = @template

    if @drool.save
      DroolTemplateField.save_drool_template_fields(@drool, params[:drool_template_fields])
      set_api_response("200", "Drool has been created successfully.")
      render :template => "/drools/show"
    else
      set_api_response("422", "Failed to create drool.")
      render :template => "/drools/new"
    end

  end

  def update
    if @drool.update_attributes(params[:drool])
      DroolTemplateField.update_drool_template_fields(@drool, params[:drool_template_fields]) if !params[:drool_template_fields].blank?
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
  
  def search_by_title
    @drools = Drool.full_text_search(:title => params[:title]).asc(:title)
    set_api_response("200", @drools.present? ? "#{@drools.size} drools found." : "No drool found.")

    respond_to do |format|
      format.json{
        render "search_results"
      }
    end
  end
  
  def search_by_location
    @drools = Drool.full_text_search(:location => params[:location], :latitude => params[:geo_location], :longitude => params[:geo_location]).asc(:title)
    set_api_response("200", @drools.present? ? "#{@drools.size} drools found." : "No drool found.")

    respond_to do |format|
      format.json{
        render "search_results"
      }
    end
  end
  
  def search_by_date
    @drools = Drool.full_text_search(:created_at => params[:date], :updated_at => params[:date]).asc(:title)
    set_api_response("200", @drools.present? ? "#{@drools.size} drools found." : "No drool found.")

    respond_to do |format|
      format.json{
        render "search_results"
      }
    end
  end
  
  def change_status
    @drool.status = params[:drool][:status]
    
    if @drool.save
      set_api_response("200", "Drool status has been changed successfully.")
      render :template => "/drools/status_changed"
    else
      set_api_response("422", "Failed to update drool status.")
      render :template => "/drools/failed_change_status"
    end
  end

  protected

  def set_template
    @template = Template.find(params[:template_id]) rescue nil

    if @template.nil?
      @object = Template.new
      set_api_response("404", "Failed to find the template.")
      return(render :template => "/shared/not_found")
    elsif @template.owner != current_user
      @object = @template
      set_api_response("401", "Failed to authorize the template.")
      return(render :template => "/shared/not_authorized")
    end
  end

  def check_drool_template_field
    if params[:drool_template_fields].blank?
      set_api_response("422", "Please provide atleast one drool template field.")
      return(render :template => "/drools/new")
    end
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
