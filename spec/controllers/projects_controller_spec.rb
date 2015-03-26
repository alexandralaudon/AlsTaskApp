require 'rails_helper'

describe ProjectsController do
  before(:each) do
    @user = create_user(admin: false)
    session[:user_id] = @user.id
  end

  describe 'Project Actions:' do

    describe 'GET #index' do
      it 'assigns all projects' do
        project = create_project
        get :index
        expect(response).to render_template(:index)
      end
    end
    describe 'GET #new' do
      it 'assigns a new project Object' do
        get :new
        expect(response).to render_template(:new)
      end
    end
    describe 'POST #create' do
      describe 'on success' do
        it 'creates a new project when passed with valid parameters' do
          expect {
            post :create, project: {name: 'Hello World'}
          }.to change{Project.count}.from(0).to(1)

          project = Project.last
          expect(project.name).to eq 'Hello World'
          expect(flash[:notice]).to eq 'Project was successfully created'
          expect(response).to redirect_to project_tasks_path(project.id)
        end
      end
      describe 'on failure' do
        it 'does not create a new project when invalid parameters are passed'do
          expect {
            post :create, project: {created_at: '01/01/2000'}
          }.to change{Project.count}.by(0)

          expect(assigns(:project)).to be_a(Project)
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #show' do
      it 'assigns one specific project object' do
        project = create_project
        create_membership(project, @user)

        get :show, id: project.id
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #edit' do
      it 'assigns a specific project Object for editing' do
        project = create_project
        create_membership(project, @user)

        get :edit, id: project.id
        expect(response).to render_template(:edit)
      end
    end

    describe 'PATCH #update' do
      describe 'on success' do
        it 'updates a project with valid attributes passed' do
          project = create_project(name: 'Custard Apple Seed Oil As Pesticide')
          create_membership(project, @user)
          expect {
            patch :update, id: project.id, project: {name: 'Extraction Of Oil From Rosemary Leaves'}
          }.to change{project.reload.name}.from('Custard Apple Seed Oil As Pesticide').to('Extraction Of Oil From Rosemary Leaves')

         expect(project.name).to eq 'Extraction Of Oil From Rosemary Leaves'
         expect(flash[:notice]).to eq 'Project was successfully updated'
         expect(response).to redirect_to project_path(project.id)
        end
      end
      describe 'on failure' do
        it 'does not update a project with invalid attributes passed' do
          project = create_project(name: 'Recovery Of Silver From Photographic Film Waste')
          create_membership(project, @user)

          expect {
            patch :update, id: project.id, project: {name: nil}
          }.to_not change{project.reload.name}

          expect(project.name).to eq 'Recovery Of Silver From Photographic Film Waste'
          expect(assigns(:project)).to eq(project)
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes a project' do
        project = create_project
        create_membership(project, @user)

        expect {
          delete :destroy, id: project.id
        }.to change{Project.all.count}.from(1).to(0)

        expect(flash[:notice]).to eq 'Project was successfully deleted'
        expect(response).to redirect_to projects_path
      end
    end

  end

  describe 'Permissions' do

    describe '#required_login:' do
      it 'redirect nonlogged in users to sign in path' do
        session[:user_id] = nil
        get :index
        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
      it 'allows logged in users to see projects#index' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe '#ensure_owner_or_member' do
      before :each do
        @project = create_project
      end
      it 'expects user to not be an owner or member of the particular project' do
        user2 = create_user(email: 'lalala@lalala.com')
        membership = create_membership(@project, user2)
        get :show, id: @project.id
        expect(response).to redirect_to projects_path
        expect(flash[:danger]).to eq 'You do not have access to that project'
      end

      it 'expects user to be an owner or member of the particular project' do
        membership = create_membership(@project, @user)
        get :show, id: @project.id
        expect(response).to render_template(:show)
      end
    end

    describe '#require_project_ownership' do
      before :each do
        @project = create_project
      end
      it 'expects project member to be unable to update or delete projects' do
        membership = create_membership(@project, @user, role: 'Member')
        get :edit, id: @project.id
        expect(response).to redirect_to projects_path
      end

      it 'expects project owner to update or delete projects' do
        membership = create_membership(@project, @user, role: 'Owner')
        get :edit, id: @project.id
        expect(response).to render_template(:edit)
      end
    end

  end


end
