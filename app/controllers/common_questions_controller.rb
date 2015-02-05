class CommonQuestionsController < ApplicationController


    def index
      @cq1 = CommonQuestion.all
    end
    
end
