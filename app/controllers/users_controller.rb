class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    # You can display associated models (ex: @user.tasks) in the show view.
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    # Require password challenge for update
    if @user.authenticate(params[:user][:password_challenge])
      # Update attributes (email, password etc.)
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
    # Permit password_challenge for verification, but don't save it to DB
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end