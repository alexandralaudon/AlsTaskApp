class PrivateController < ApplicationController
  before_action :require_login

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

  def ensure_owner_or_member
    unless @project.users.pluck(:id).include?(current_user.id) || current_user.admin
      flash[:danger] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

  def require_project_ownership
    unless @project.memberships.where(user_id: current_user.id).pluck(:role) == ["Owner"] || current_user.admin
      flash[:danger] = 'You do not have access'
      redirect_to projects_path
    end
  end

end
