class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You registered successfully"
      redirect_to root_path
    else
      render :new
    end
  end
end


private

def user_params
  params.require(:user).permit(:username, :password)
end
