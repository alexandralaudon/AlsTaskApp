require 'rails_helper'

describe CommentsController do
  before(:each) do
    user = create_user
    session[:user_id] = user.id
    @project = create_project
    @task = create_task(@project)
  end

  describe "POST #create" do
    describe "on success" do
      it "creates a new comment when valid parameters are passed" do
        expect {
          post :create, task_id: @task.id, comment: { message: "I work, or do I...?"}
        }.to change {Comment.all.count}.by(1)

        comment = Comment.last
        expect(comment.message).to eq "I work, or do I...?"
        expect(flash[:notice]).to eq nil
        expect(response).to redirect_to project_task_path(@project.id, @task.id)
      end
    end

    describe "on failure" do
      it "does not add a new comment if it is invalid" do
        expect {
          post :create, task_id: @task.id, comment: { message: ""}
        }.to_not change {Comment.all.count}

        comment = Comment.last
        expect(flash[:notice]).to eq nil
        expect(response).to redirect_to project_task_path(@project.id, @task.id)
        expect(assigns(:comment)).to be_a(Comment)
      end
    end

  end
end
