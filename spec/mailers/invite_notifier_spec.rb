require "rails_helper"

RSpec.describe InviteNotifierMailer, type: :mailer do
  it "invite" do
    VCR.use_cassette("invite-github") do
      user = create(:user)
      mail = InviteNotifierMailer.invite('octocat', user)

      expect(mail.subject).to eq("You've been invited by #{user.first_name}")
      expected = "#{user.first_name} has invited you to join Brownfield. You can create an account here: https://hidden-springs-90979.herokuapp.com/register"
      expect(mail.body.encoded).to have_content(expected)
    end
  end
end
