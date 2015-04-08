class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end
  
  def show
    #show the users details
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy!
  end
  
  protected
  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
