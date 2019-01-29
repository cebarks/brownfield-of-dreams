class UserDashboardFacade
  def initialize(user)
    @user = user
  end

  def user_repos(count)
    repo_list[0...count].map do |repo|
      GithubRepo.new(repo)
    end
  end

  private

  def repo_list
    @repo_list ||= service.repos
  end

  def service
    GithubService.new({access_key: @user.token})
  end
end