class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

      @user.password=params[:user][:password]
      @user.password_confirmation=params[:user][:password_confirmation]

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample App"
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update

      @user.password=params[:user][:password]
      @user.password_confirmation=params[:user][:password_confirmation]

    if @user.update(user_params)
      sign_in @user
      flash[:success] = "Profile Updated"
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    flash[:success] = "User destroyed"
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email)
    end


    def correct_user
        @user = User.find(params[:id])
        redirect_to root_path unless current_user?(@user)
    end

    def admin_user 
        redirect_to root_path unless current_user.admin?
    end
end

