class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks
    @comment = @task.comment.new
  end
end
