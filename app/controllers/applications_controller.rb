class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update]

  def show
    if params[:pet_name]
      @pets = Pet.search_for_pet(params[:pet_name])
    elsif params[:pet_id]
      pet = Pet.find(params[:pet_id])
      @application.pets << pet
    end
    @application
  end

  def new
  end

  def create
    @application = Application.new(app_params)
    if @application.save
      flash[:notice] = "Application was successfully started"
      redirect_to application_path(@application)
    else
      flash[:notice] = "ERROR: Missing Field"
      redirect_to new_application_path
    end
  end

  def update
    @application.update(description: params[:description],
                        status: "Pending"
                       )
    redirect_to application_path(@application)
  end

  private
  def set_application
    @application = Application.find(params[:id])
  end

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end