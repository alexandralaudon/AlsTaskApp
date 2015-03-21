class ProjectsController < PrivateController

  before_action :require_memberships_for_projects, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @membership = @project.memberships.create!(user_id: current_user.id, role: "Owner")
      redirect_to project_tasks_path(@project.id), notice: "Project was successfully created"
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
    @memberships = @project.memberships
  end

  def edit
    @project = Project.find(params[:id])
    @task = @project.tasks
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to project_path(@project), notice: "Project was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_path, notice: "Project was successfully deleted"
  end

private

  def project_params
    params.require(:project).permit(:name, :created_at, :updated_at)
  end

end
