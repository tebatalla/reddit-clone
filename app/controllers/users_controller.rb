class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = current_user
    render :show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      flash[:notice] = ["User created"]
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def user_params
      self.params.require(:user).permit(:username, :password)
    end

end
