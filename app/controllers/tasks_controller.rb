class TasksController < PrivateController
  before_action :project_instance_variable, except: [:destroy]

  def index
    @tasks = @project.tasks
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created!"
      redirect_to project_task_path(@project, @task[:id])
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
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

  def project_instance_variable
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :complete, :due_date, :project_id)
  end

end
