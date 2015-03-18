require 'rails_helper'

describe CommentsController do
  describe "POST #create" do
    describe "on success" do
      it "creates a new comment when valid parameters are passed" do
        user = User.create!(first_name: "Isaac", last_name: "Newton", email: "invented@calc.sin", password: "password")
        session[:user_id] = user.id
        project = Project.create!(name: "How to get better at programming")
        task = Task.create!(description: "I need to work on my specs", project_id: project.id)

        expect {
          post :create, task_id: task.id, comment: { message: "I work, or do I...?"}
        }.to change {Comment.all.count}.by(1)

        comment = Comment.last
        expect(comment.message).to eq "I work, or do I...?"
        expect(flash[:notice]).to eq nil
        expect(response).to redirect_to project_task_path(project.id, task.id)
      end
    end

    describe "on failure" do
      it "does not add a new comment if it is invalid" do

        user = User.create!(first_name: "Isaac", last_name: "Newton", email: "invented@calc.sin", password: "password")
        session[:user_id] = user.id
        project = Project.create!(name: "How to get better at programming")
        task = Task.create!(description: "I need to work on my specs", project_id: project.id)

        expect {
          post :create, task_id: task.id, comment: { message: ""}
        }.to_not change {Comment.all.count}

        comment = Comment.last
        expect(flash[:notice]).to eq nil
        expect(response).to redirect_to project_task_path(project.id, task.id)
        expect(assigns(:comment)).to be_a(Comment)
      end
    end

    

  end
end
