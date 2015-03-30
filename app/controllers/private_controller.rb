class PrivateController < ApplicationController
  before_action :require_login
  helper_method :membership_sharing?

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

  def ensure_current_user_cannot_change
    if !current_user
      record_not_found
    end
  end

  def ensure_owner_or_member
    unless @project.users.pluck(:id).include?(current_user.id) || ensure_admin?
      flash[:danger] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

  def require_project_ownership
    unless @project.memberships.where(user_id: current_user.id) || ensure_admin?
      flash[:danger] = 'You do not have access'
      redirect_to projects_path
    end
  end

  def membership_sharing?(user)
    if current_user.admin
      return true
    else
      current_user_projects = current_user.projects.pluck(:project_id)
      user_projects = user.memberships.pluck(:project_id)
      !(current_user_projects & user_projects).empty?
    end
  end

end
