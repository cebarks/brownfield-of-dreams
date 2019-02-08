class InvitesController < ApplicationController
  def new
  end

  def create
    InviteNotifierMailer.invite(params[:invite][:github_user], current_user).deliver_now
    flash[:notice] = "Successfully sent invite!"
    #flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    redirect_to dashboard_url
  end
end
