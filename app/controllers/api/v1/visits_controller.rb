class Api::V1::VisitsController < ApplicationController

  def create
    @visit = Visit.new(user_id: current_user.id, establishment_id: params["establishmentId"])
    #find users other visits. If one is active, deactivate it. then create this vist and set active.
    @visits = Visit.where(user_id: @visit.user_id)

    currentActiveVisit = {}
    currentActiveVisit = @visits.find{|visit| visit.active == true}

    if currentActiveVisit

      if(currentActiveVisit.establishment_id == @visit.establishment_id)
        # user already has an active session here... return that visit
      else
        #user is visiting a different location than where they previously were.
        #is our new visit valid?
        if @visit.valid?
          currentActiveVisit.active = false
          currentActiveVisit.save
          currentActiveVisit = @visit
          currentActiveVisit.active = true
          currentActiveVisit.save
          #our visit is valid, so lets set it as the new active visit.
        else
          #our visit is not valid.. keep old active visit

        end
      end

    else
      #user has no visits that are active... set this to active
      @visit.active = true
      currentActiveVisit = @visit.save

    end
    render :json => {visit: currentActiveVisit}.as_json
  end

  def update
    @visit = Visit.find(params[:id])
    if(Visit.find(params[:id]).update_attributes(ratingChange))
        render json: {message:"Updated Successfully"},status: :accepted
    else
      render json: {error:"Failed to update"},status: :bad_request
    end
  end

  private

  def ratingChange
    params.require(:visit).permit(:rating)
  end

end
