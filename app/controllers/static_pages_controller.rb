class StaticPagesController < ApplicationController
  def index
    @quotes =
      [
        { author: "-Cayla Hayes", text: "gCamp has changed my life! It's the best tool I've ever used."
        },
        {author: "-Leta Jaskolski", text: "Before gCamp I was a disorderly slob. Now I'm more organized than I've ever been"
        },
        {author: "-Lavern Upton", text: "Don't hesitate - sign up right now! You'll never be the same."
        }
      ]
  end

  def faq
    @results = CommonQuestion.create_array
  end

  def terms
  end

  def about_page
    @projects     = Project.all
    @tasks        = Task.all
    @memberships  = Membership.all
    @users        = User.all
    @comments     = Comment.all
  end

end
