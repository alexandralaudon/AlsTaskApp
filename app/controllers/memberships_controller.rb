class MembershipsController < PrivateController
  before_action :project_instance_variable
  before_action :require_memberships_for_projects_tasks
  before_action :require_ownership_for_memberships, only: [:edit, :update]
  before_action :memberships_must_have_one_owner, only: [:update, :destroy]

  def index
    @memberships = @project.memberships
    @membership = Membership.new
  end

  def create
    @memberships = @project.memberships.reject {|m| m.id.nil?}
    @membership = @project.memberships.new(membership_params)

    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def update
    @memberships = @project.memberships.reject {|m| m.id.nil?}
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def destroy
    member = Membership.find(params[:id])
    member.destroy
    flash[:notice] = "#{member.user.full_name} was successfully removed"

    if member.user_id == current_user.id
      redirect_to projects_path
    else
      redirect_to project_memberships_path
    end

  end

  private

  def project_instance_variable
    @project = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:project_id, :user_id, :role)
  end

  def memberships_must_have_one_owner
    @membership = Membership.find(params[:id])
    unless @membership.role == 'Owner' && @project.memberships.where(role: "Owner").count > 1
      flash[:danger] = 'Projects must have at least one owner'
      redirect_to project_memberships_path
    end
  end
end
