class RatingsController < ApplicationController
    before_action :new
    def new 
        @rating = @user.ratings.last
    end
    def create
        @rating.comment = params[:rating][:comment]
        @rating.rating_number = params[:rating][:rating_number]
        respond_to do |format|
            if @rating.save
               
                redirect_to user_path(@user)
            else
                format.html { redirect_to welcome_path, notice: "error with rating" }
                format.json { render json: @rating.errors, status: :unprocessable_entity }
            end
        end
    end

    def index
        @ratings = Rating.all
    end

    def update
        respond_to do |format|
          if @rating.update(rating_params)
            format.html { redirect_to welcome_path, notice: "Review was successfully updated." }
           # format.json { render :show, status: :ok, location: @user }
          else
            format.html { render 'ratings/form', status: :unprocessable_entity }
            format.json { render json: @rating.errors, status: :unprocessable_entity }
          end
        end
      end
    private
    def rating_params
        params.require(:rating).permit( :comment, :rating_number, :user_id, :reviewer_id)
    end
   
end
