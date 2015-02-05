class CommonQuestion < ActiveRecord::Base

  def initialize(question, answer)
    @question = question
    @answer = answer
    @slug = @question.downcase.join("-")
  end

end

@cq1 = CommonQuestion.new["What is gCamp?", "gCamp is an awesome tool that is going to change your life. gCamp is your one stop shop to organize all your tasks. You'll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's going to be pretty cool."]
