class PropertiesController < ApplicationController
  has_many_attached :photos
  before_action :set_flat, only: [:show, :update, :destroy]

  def index
    @properties = Property.all
  end

  def show
    @booking = Booking.new
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.user_id = current_user.id
    if @property.save
      redirect_to property_path(@property)
    else
      render :new
    end
  end

  private

  def set_flat
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :address, :city, :zipcode, :overview, :rating, :price_per_night, :guest_capacity, :photos : [])
  end
end
