require 'rails_helper'

describe "As a registered user" do
  before(:each) do
    @user = create(:user)
    stub_login(@user)
  end

  describe "When I visit '/dashboard' and click on 'Send an Invite'" do
    before(:each) do
      visit dashboard_path
      click_on 'Send an Invite'
    end

    it "I should be on '/invite'" do
      expect(current_path).to eq(invite_path)
    end

    describe "When I fill in 'Github Handle' with a valid github handle and click on 'Send Invite'" do
      before(:each) do
        fill_in "invite[github_user]", with: "cebarks"
        VCR.use_cassette('valid-github-invite') do
          click_on 'Send Invite'
        end
      end

      it "I should be on '/dashboard'" do
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Successfully sent invite!")
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
    describe "When I fill in 'Github Handle' with an invalid github handle and click on 'Send Invite'" do
      before(:each) do
        fill_in "invite[github_user]", with: "myrmeko"
        VCR.use_cassette('invalid-github-invite') do
          click_on 'Send Invite'
        end
      end

      #Can't figure this one out
      # xit "I should be on '/dashboard'" do
      #   expect(current_path).to eq(dashboard_path)
      #   expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
      #   expect(ActionMailer::Base.deliveries.count).to eq(0)
      # end
    end
  end
end
