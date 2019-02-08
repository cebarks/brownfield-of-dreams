class GithubUser
  attr_reader :handle, :url, :email

  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:html_url]
    @id = attributes[:id]
    @email = attributes[:email]
  end

  def exists_in_database?
    true if user_in_database
  end

  def user_in_database
    User.find_by(uid: @id)
  end
end
