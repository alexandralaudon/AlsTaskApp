class TermsController < ApplicationController

  def index
  end

  def about_page
    @projects     = Project.all
    @tasks        = Task.all
    @memberships  = Membership.all
    @users        = User.all
    @comments     = Comment.all
  end

end
