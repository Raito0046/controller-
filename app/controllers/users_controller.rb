class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to @user, notice: "Account created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.authenticate(params[:user][:password_challenge])
      if @user.update(user_params)
        redirect_to @user, notice: "Profile was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Current password is incorrect."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "Account deleted successfully."
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Not authorized" unless @user == Current.user
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :password_challenge
    )
  end
end
