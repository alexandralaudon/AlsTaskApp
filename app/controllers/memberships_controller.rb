class MembershipsController < ApplicationController
  before_action :require_login

  def index
    @project = Project.find(params[:project_id])
    @memberships = @project.memberships
    @membership = Membership.new
  end

  def create
    @project = Project.find(params[:project_id])
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
    @project = Project.find(params[:project_id])
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
    redirect_to project_memberships_path
  end

  private

  def membership_params
    params.require(:membership).permit(:project_id, :user_id, :role)
  end
end
