class Api::V1::EstablishmentsController < ApplicationController

  def index
    @establishments = Establishment.all
    render json: @establishments.as_json(:only => [:id,:name,:domain,:address,:genre,:picture_url], :methods =>[:rating])
  end

  def show

  end

  def create
    @establishment = Establishment.create(new_establishment_params)
    if(@establishment.valid?)
      @user_establishment = UserEstablishment.create({user_id:params["user"]["id"],establishment_id:@establishment.id})
      render json: {establishment: EstablishmentSerializer.new(@establishment) },status: :created
    else
      render json: {error: 'failed to create establishment' }, status: :not_acceptable
    end
  end

  def update
    if(Establishment.find(params[:id]).update_attributes(new_establishment_params))
        render json: {message:"Updated Successfully"},status: :accepted
    else
      render json: {error:"Failed to update"},status: :bad_request
    end

  end

  def search

    arr = Establishment.radialSearch(params["search"]["amount"].to_i,[params["search"]["latitude"],params["search"]["longitude"]],params["search"]["maxDistance"].to_i)

    output = arr.map do |element|
      element[0]
    end
    render json: output.as_json(:only => [:id,:name,:domain,:genre,:picture_url,:latitude,:longitude,:address], :methods =>[:rating])
  end

  private

  def new_establishment_params
    params.require(:establishment).permit(:name,:domain,:description,:genre,:picture_url,:address,:latitude,:longitude)
  end

  def map_search_params
    params.require(:search).permit(:latitude,:longitude,:amount,:maxDistance)
  end

end
