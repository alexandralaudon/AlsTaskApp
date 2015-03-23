class UsersController < PrivateController
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
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    record_not_found unless current_user.id == @user.id || current_user.admin
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
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

  def personal_profile?(user)
    current_user.id == user.id
  end


end
