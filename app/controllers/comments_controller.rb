class CommentsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @comment = Comment.new(comments_params.merge(task_id: params[:task_id]))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to project_task_path(@task[:project_id], @task[:id])
    else
      redirect_to project_task_path(@task[:project_id], @task[:id])
    end
  end

  private

  def comments_params
      params.require(:comment).permit(:message, :created_at, :user_id, :task_id)
  end
end
