class UsersController < ApplicationController
  def show
    @facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      ModelMailer.new_record_notification(@user).deliver_now
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Email already in use'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
