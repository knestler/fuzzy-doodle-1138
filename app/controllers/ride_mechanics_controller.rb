class RideMechanicsController < ApplicationController
  def create
    @mechanic = Mechanic.find(params[:mechanic_id])
    @ride = Ride.find(params[:ride_id])
    RideMechanic.create!(ride: @ride, mechanic: @mechanic)
    redirect_to mechanic_path(@mechanic)
  end
end