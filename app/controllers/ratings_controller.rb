class RatingsController < ApplicationController
   # before_action :set_user
    def new 
        @rating = Rating.new
    end

    def create
    
      @rating = Rating.new(rating_params)
     
        respond_to do |format|
            if @rating.save
                format.html { redirect_to user_path(@rating.user_id), notice: "Rating was successfully created." }
            else
                format.turbo_stream
                #format.html { render :user_path(@rating.user_id), status: :unprocessable_entity }
                format.json { render json: @rating.errors.full_messages, status: :unprocessable_entity }
               
               
            end
        end  
    end

    def show
        if @rating.reviewer_id == current_user.id
            render 'show'
        else
            redirect_to @user 
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

    def set_rating
        @rating = Rating.find(params[:id])
    end

    def set_user
        @user = User.find(params[:user_id])
    end
end
