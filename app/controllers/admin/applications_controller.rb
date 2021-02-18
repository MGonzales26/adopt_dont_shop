class Admin::ApplicationsController < ApplicationController
  before_action :get_application, only: [:show]
  def show
    if params[:pet_id]
      pet = Pet.find(params[:pet_id])
      pet.approve_pet(params[:id], params[:approval])
      @application_pet = pet.application_pets.where(application_id: params[:id], pet_id: params[:pet_id]).first
      if @application.application_pets.where(approval: "rejected")
        
      end
    end
    @application
  end
  
  private
  def get_application
    @application = Application.find(params[:id])
  end
end