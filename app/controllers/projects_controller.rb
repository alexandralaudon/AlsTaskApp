class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.save
    redirect_to projects_path, notice: "Project was successfully created"
  end


private

  def project_params
    params.require(:project).permit(:name, :created_at, :updated_at)
  end

end
