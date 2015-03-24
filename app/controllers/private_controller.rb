class PrivateController < ApplicationController
  before_action :require_login

  helper_method :ensure_admin

  def ensure_admin
    current_user.admin
  end

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

  def ensure_owner_or_member
    unless @project.users.pluck(:id).include?(current_user.id) || ensure_admin
      flash[:danger] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

  def require_project_ownership
    unless @project.memberships.where(user_id: current_user.id).pluck(:role) == ["Owner"] || ensure_admin
      flash[:danger] = 'You do not have access'
      redirect_to projects_path
    end
  end

end
