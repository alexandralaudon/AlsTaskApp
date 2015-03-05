class CommonQuestionsController < ApplicationController
  skip_before_action :require_login
  
  def index
    @results = CommonQuestion.create_array
  end
end
