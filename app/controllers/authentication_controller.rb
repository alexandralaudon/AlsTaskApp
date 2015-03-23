class AuthenticationController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully signed in'
      redirect_to(session[:return_to] || projects_path)
    else
      @invalid_combo = 'Email / Password combination is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:return_to] = nil
    flash[:notice] = 'You have successfully logged out'
    redirect_to root_path
  end

end
