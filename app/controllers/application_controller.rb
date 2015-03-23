class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def require_login
    unless current_user
      flash[:danger] = "You must sign in"
      session[:return_to] ||= request.url
      redirect_to sign_in_path
    end
  end

  def redirect_back_or_default(default)
    redirect_to session[:return_to]
  end

end
