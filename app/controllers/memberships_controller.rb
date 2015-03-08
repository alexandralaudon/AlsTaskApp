class MembershipsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @users = @project.users
  end
end
