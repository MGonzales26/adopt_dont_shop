class ApplicationsController < ApplicationController
  
  def show
    if params[:search]
      @application = Application.find(params[:id])
       @pets = Application.search(params[:search])
    else
      @application = Application.find(params[:id])
    end
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
        flash.now[error] = "Submission not accepted: Required information missing."
        render :new
      end
  end

  def update
    # require 'pry'; binding.pry
  end
end