require 'rails_helper'

describe "As a logged in user" do
  before(:each) do
    @user = create(:user, github_token: ENV["GITHUB_ACCESS_TOKEN"])
    @user_2 = create(:user, uid: 36653285)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "When I visit /dashboard", js: true do
    it "I should see an 'Add Friend' button next to the handle of a user within the database" do
      VCR.use_cassette('github_add_friend') do
        visit dashboard_path

        expect(page).to have_button("Add Friend")
        click_on "Add Friend"

        expect(page).to have_content("Added friend: #{Friendship.first.friend.first_name}")

        within "#friends" do
          expect(page).to have_content("#{@user_2.first_name} #{@user_2.last_name}")
        end
      end
    end

    it "I can remove a friend" do
      VCR.use_cassette('github_add_friend') do
        visit dashboard_path

        expect(page).to have_button("Add Friend")

        click_on "Add Friend"

        within "#friends" do
          expect(page).to have_button("Remove Friend")

          click_on("Remove Friend")

          expect(page).to_not have_content("#{@user_2.first_name} #{@user_2.last_name}")
          expect(current_path).to eql(dashboard_path)
        end

        expect(page).to have_content("Friend removed.")
      end
    end
    it "I can't remove a user as a friend that is not my friend" do
      VCR.use_cassette("Weird remove friend") do

        current_driver = Capybara.current_driver
        Capybara.current_driver = :rack_test
        page.driver.submit :delete, user_friendship_path(@user, @user_2), {}
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("This folk is not your buddy")
        Capybara.current_driver = current_driver

      end
    end
  end
end
