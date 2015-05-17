class CommonQuestion
  attr_reader :question, :answer, :slug
  def initialize(question, answer)
    @question = question
    @answer = answer
    @slug = @question.downcase.gsub(" ","-")
  end

  def self.create_array()
    [CommonQuestion.new("What is Al's Task App?", "Al's Task App is an awesome tool that is going to change your life. Al's Task App is your one stop shop to organize all your tasks. You'll also be able to track comments that you and others make. Al's Task App may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's going to be pretty cool."),
    CommonQuestion.new("How do I join Al's Task App?","As soon as it's ready for the public, you'll see a signup link in the upper right. Once that's there, just click it and fill in the form!"),
    CommonQuestion.new("When will Al's Task App be finished?", "Al's Task App is a work in progress. That being said, it should be fully functional in the next few weeks. Functional. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is just a click away. Amazing!")]
  end
end
