class PrivateController < ApplicationController
  before_action :require_login

  helper_method :require_memberships_for_projects, :require_memberships_for_projects_tasks

  def require_memberships_for_projects
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

end
