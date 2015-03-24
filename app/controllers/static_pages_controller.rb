class StaticPagesController < ApplicationController

  def index
    @quotes = Quote.all
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
