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
    @projects     = Project.all.count
    @tasks        = Task.all.count
    @memberships  = Membership.all.count
    @users        = User.all.count
    @comments     = Comment.all.count
  end

end
