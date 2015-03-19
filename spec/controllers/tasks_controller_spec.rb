require 'rails_helper'

describe TasksController do
  before(:each) do
    user = create_user
    session[:user_id] = user.id
    @project = create_project
  end

  describe 'GET #index' do
    it "assigns all tasks" do
      task = create_task(@project)

      get :index, :project_id => @project.id
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it "assigns a new Task object" do
      get :new, project_id: @project.id
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do
    it 'creates a new task when valid parameters are passed' do
      expect {
        post :create, project_id: @project.id, task: {description: "Simplifying complex reality", due_date: '01/01/2000'}
      }.to change {Task.all.count}.by(1)

      task = Task.last
      expect(task.description).to eq "Simplifying complex reality"
      expect(task.due_date.strftime("%m/%d/%Y")).to eq '01/01/2000'
      expect(task.project_id).to eq @project.id
      expect(flash[:notice]).to eq "Task was successfully created!"
      expect(response).to redirect_to project_task_path(task.project_id, task.id)
    end
    it 'does not create a new task when invalid parameters are passed' do
      expect {
        post :create, project_id: @project.id, task: {due_date: '02/02/2002'}
      }.to_not change {Task.all.count}

      expect(response).to render_template(:new)
      expect(assigns(:task)).to be_a(Task)
    end
  end



end
