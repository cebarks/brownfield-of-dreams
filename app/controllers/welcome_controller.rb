class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = which_tutorials.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = which_tutorials.paginate(:page => params[:page], :per_page => 5)
    end
  end

  private

  def which_tutorials
    if current_user
      Tutorial.all
    else
      Tutorial.without_classroom
    end
  end
end
