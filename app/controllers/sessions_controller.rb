class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:user][:username],
      session_params[:user][:password]
      )
    if @user.nil?
      flash.now[:errors] = "Invalid login"
      render :new
    else
      log_in!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    @user = current_user
    log_out!(@user)
  end

  private
    def session_params
      params.require(:user).permit(:username, :password)
    end

end