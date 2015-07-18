class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user!(user)
      end
    else
      flash.now[:error] = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to root_path
  end

  def pin
    access_denied if session[:two_factor].nil?

    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = "Incorrect PIN"
        redirect_to pin_path
      end
    end
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = "Welcome #{user.username}, you're now logged in"
    redirect_to root_path
  end
end
