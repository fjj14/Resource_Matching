class RatingsController < ApplicationController
    def new 
    end
    def create
        @rating = Rating.new(rating_params)
        @rating[:reviewer_id] = session[user_id]
    end

    private
    def rating_params
        params.require(:rating).permit( :user_id, :comment, :rating_number)
      end
end
