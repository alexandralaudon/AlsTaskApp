require 'rails_helper'

describe TasksController do
  describe 'GET #Index' do
    it "assigns all tasks" do
      user = create_user
      project = create_project
      task = create_task(project)
      task1 = create_task(project, description: "That's whaz up")

    end



  end




end
