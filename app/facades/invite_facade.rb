class InviteFacade
  def initialize(github_user, user)
    @invitee = github_user
    @inviter = user
  end

  def invitee_email
    service.email(@invitee)
  end

  def invitee_name
    @invitee
  end

  def inviter_name
    @inviter.first_name
  end

  private

  def service
    @service ||= GithubService.new(ENV["GITHUB_ACCESS_TOKEN"])
  end
end
