class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.new(app_params)
    # require 'pry'; binding.pry
    if @application.save
      flash[:notice] = "Application was successfully Submitted"
      redirect_to application_path(@application)
    else
      flash[:notice] = "ERROR: Missing Field"
      redirect_to new_application_path
    end
  end

  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end