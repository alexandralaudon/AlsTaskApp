class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'You have successfully signed up'
      session[:user_id] = @user.id
      redirect_to(session[:return_to] || new_project_path)
    else
      render :new
    end
  end
end
