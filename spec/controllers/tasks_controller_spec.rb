require 'rails_helper'

describe TasksController do
  before(:each) do
    user = create_user
    session[:user_id] = user.id
  end

  describe 'GET #index' do
    it "assigns all tasks" do
      project = create_project
      task = create_task(project)

      get :index, :project_id => project.id
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it "assigns a new Task object" do
      project = create_project
      get :new, project_id: project.id
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do
    it



end
