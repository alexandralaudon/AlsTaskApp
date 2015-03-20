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

      get :index, project_id: task.project_id
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

  describe 'GET #show' do
    it 'assigns one particular task' do
      task = create_task(@project)
      user2 = create_user(email: 'whadda@say.yyyy')

      comment1 = create_comment(task, user2, message:'thats whaz up')
      comment2 = create_comment(task, user2, message:'I told you so')
      expect(comment1.message).to eq 'thats whaz up'
      expect(comment2.message).to eq 'I told you so'

      get :show, project_id: task.project_id, id: task.id
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'assigns a previous task' do
      task = create_task(@project)
      get :edit, project_id: task.project_id, id: task.id
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    describe 'on success' do
      it 'updates a task with valid attributes' do
        task = create_task(@project)
        expect {
          patch :update, project_id: task.project_id, id: task.id, task: {description: 'What did the fox say?'}
        }.to change{task.reload.description}.from('Simplifying complex reality').to('What did the fox say?')

        expect(response).to redirect_to project_task_path(task.project_id, task.id)
        expect(flash[:notice]).to eq "Task was successfully updated!"
      end
    end
    describe 'on failure' do
      it 'does not update because of invalid attributes' do
        task = create_task(@project)
        expect {
          patch :update, project_id: task.project_id, id: task.id, task: {description: nil, due_date: '03/03/3012'}
        }.to_not change{task.reload.description}

        expect(assigns(:task)).to eq(task)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a task' do
      task = create_task(@project)
      expect {
        delete :destroy, project_id: task.project_id, id: task.id
      }.to change{Task.all.count}.from(1).to(0)

      expect(response).to redirect_to project_tasks_path(task.project_id)
      expect(flash[:notice]).to eq "Task was successfully deleted!"
    end
  end



end
