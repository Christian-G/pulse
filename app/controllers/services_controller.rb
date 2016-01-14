class ServicesController < ApplicationController

  def index
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to service_path(@service)
    else
      render action: 'new'
    end
  end

  def show
  end


private

  def service_params
    params.require(:service).permit(:name, :description)
  end

end