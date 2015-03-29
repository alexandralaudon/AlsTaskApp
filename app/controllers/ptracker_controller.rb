class PtrackerController < PrivateController

  def show
    pivotal_tracker = TrackerAPI.new
    @stories = pivotal_tracker.stories(current_user.pt_token, params[:id])
    @projects = pivotal_tracker.projects(current_user.pt_token)
    #.where(project_id: @stories[0][:project_id]).first
  end

end
