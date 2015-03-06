class TasksController < ApplicationController
  before_action :require_login

  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created!"
      redirect_to project_task_path(@project, @task[:id])
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def edit
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task[:id]), notice: "Task was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to project_tasks_path, notice: "Task was successfully deleted!"
  end


  private

  def task_params
    params.require(:task).permit(:description, :complete, :due_date, :project_id)
  end

end
