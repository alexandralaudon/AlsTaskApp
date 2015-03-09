class MembershipsController < ApplicationController
  before_action :require_login

  def index
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:project_id, :user_id, :role)
  end
end
