class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_rating, only: %i[ show ]
  before_action :average_rating, only: %i[show]
  
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  #
  def show
    @rating = set_rating
  end

  # GET /users/new
  def new
    @user = User.new
  end
  def name
    @user.username
  end
  def mailboxer_email(object)
    self.email
    if object.class == Mailboxer::Notification
      email
    end

  end
  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        #self.send_welcome
        #redirect_to welcome_path, notice: "Succesfully Created Account" 
        format.html { redirect_to welcome_path}
        #format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def average_rating
    total =0
    @current_ratings =Rating.where(user_id: @user.id)
    @current_ratings.each do |rate|
      total = total + rate.rating_number
    end

    if @current_ratings != []
      @user.average_rating = total /@current_ratings.length
    else 
      @user.average_rating = 0
    end 

  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_rating
      @rating = Rating.new
      @rating.user_id = @user.id
      return @rating
    end
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit( :first, :last, :email, :password, :password_confirmation, :image, :username, :admin)
    end
end
