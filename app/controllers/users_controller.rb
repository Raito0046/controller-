before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update, :destroy]

private

def correct_user
  @user = User.find(params[:id])
  redirect_to root_path, alert: "Not authorized" unless @user == Current.user
end
