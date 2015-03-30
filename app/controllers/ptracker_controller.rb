class PtrackerController < PrivateController

  def show
    pivotal_tracker = TrackerAPI.new
    @stories = pivotal_tracker.stories(current_user.pt_token, params[:id])
    @project_name = params[:project_name]
    @number_of_stories = 500
  end

end
