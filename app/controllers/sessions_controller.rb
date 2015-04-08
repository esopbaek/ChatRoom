class SessionsController < ApplicationController
  def create
    # signs a user in
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password],
      params[:user][:email]
    )
    if @user.nil?
      #no user with a given name
      @user = User.new
      render :new
    else
      #sign the user in
      log_in!(@user)
      redirect_to user_url(@user)
    end
  end
  
  def new
    @user = User.new
    # presents a login forms
  end
  
  def destroy
    # signs a user out
    log_out!
    redirect_to new_session_url
  end
end