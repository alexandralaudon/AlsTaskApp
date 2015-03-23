class ProjectsController < PrivateController
  before_action :project_instance_variable, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner_or_member, only: [:show, :edit, :update, :destroy]
  before_action :require_project_ownership, only: [:edit, :update, :destroy]

  def index
    ensure_admin ? @projects = Project.all : @projects = current_user.projects
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
    @tasks = @project.tasks
    @memberships = @project.memberships
  end

  def edit
    @task = @project.tasks
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: "Project was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted"
  end

private

  def project_instance_variable
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :created_at, :updated_at)
  end

end
