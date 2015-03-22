class PrivateController < ApplicationController
  before_action :require_login

  def ensure_project_owner_or_member
    @project = Project.find(params[:id])
    unless @project.users.pluck(:id).include?(current_user.id)
      flash[:danger] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

  def require_memberships_for_projects_tasks
    @project = Project.find(params[:project_id])
    unless @project.users.pluck(:id).include?(current_user.id)
      flash[:danger] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

  def require_ownership_for_projects
    @project = Project.find(params[:id])
    unless @project.memberships.where(user_id: current_user.id).pluck(:role) == ["Owner"]
      flash[:danger] = 'You do not have access'
      redirect_to projects_path
    end
  end

  def require_ownership_for_memberships
    @project = Project.find(params[:project_id])
    unless @project.memberships.where(user_id: current_user.id).pluck(:role) == ["Owner"]
      flash[:danger] = 'You do not have access'
      redirect_to projects_path
    end
  end

end
