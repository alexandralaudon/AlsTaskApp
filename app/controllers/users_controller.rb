class UsersController < PrivateController
  before_action :set_user_variable, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user_cannot_change, only: [:edit, :update, :destroy]

  helper_method :personal_profile?

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User was successfully created!"
    else
      render :new
    end
  end

  def show
  end

  def edit
    record_not_found unless ensure_admin?
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:notice] =  "User was successfully deleted!"
    if personal_profile?(user)
      session[:user_id] = nil
      redirect_to sign_in_path
    else
      redirect_to users_path
    end
  end

  private

  def set_user_variable
    @user = User.find(params[:id])
  end

  def personal_profile?(user)
    current_user.id == user.id
  end


end
