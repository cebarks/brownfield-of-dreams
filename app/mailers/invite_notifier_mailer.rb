class InviteNotifierMailer < ApplicationMailer
  def invite(github_user, inviter)
    @invite = InviteFacade.new(github_user, inviter)

    return nil unless @invite.invitee_email

    mail(to: @invite.invitee_email, subject: "You've been invited by #{@invite.inviter_name}")
  end
end
