class UsersController <ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to users_path, notice: "User was successfully created!"
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User was successfully updated!"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, notice: "User was successfully deleted!"
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end


end
