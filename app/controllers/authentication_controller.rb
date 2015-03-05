class AuthenticationController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully signed in'
      redirect_to root_path
    else
      @invalid_combo = 'Email / Password combination is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have successfully logged out'
    redirect_to root_path
  end

end
