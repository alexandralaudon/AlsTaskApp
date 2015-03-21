class PrivateController < ApplicationController
  before_action :require_login

  helper_method :require_memberships

  def require_memberships
    @project = Project.find(params[:id])
    unless @project.users.pluck(:id).include?(current_user.id)
      flash[:danger] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

end
