class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      status: "In Progress"
      })
      if @application.save
        redirect_to "/applications/#{@application.id}"
      else
        flash[:notice] = "Submission not accepted: Required information missing."
        render :new
      end
  end
end