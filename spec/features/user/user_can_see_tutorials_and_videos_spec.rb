require 'rails_helper'

describe "As a logged in user" do
  before(:each) do
    user = create(:user, id: 1, github_token: ENV["GITHUB_ACCESS_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    tutorial = create(:tutorial, id: 1, title: "Back End Engineering - Prework")
    video_1 = create(:video, video_id: 1, tutorial_id: 1, title: "Learn Ruby the Right Way", position: 1)
    video_2 = create(:video, video_id: 2, tutorial_id: 1, title: "Learn Rails the Right Way", position: 2)
    video_3 = create(:video, video_id: 3, tutorial_id: 1, title: "Learn Active Record Queries", position: 3)
    user_vid_1 = create(:user_video, user_id: 1, video_id: 1)
    user_vid_2 = create(:user_video, user_id: 1, video_id: 2)
    user_vid_2 = create(:user_video, user_id: 1, video_id: 3)
  end

  describe "When I visit /dashboard" do
    it "I should see a tutorial with its videos in sequential order" do
      VCR.use_cassette("github-tutorial-videos") do
        visit dashboard_path

        within("#tutorial") do
          expect(page).to have_content("Back End Engineering - Prework")
          expect(page).to have_content("Learn Ruby the Right Way")
          expect(page).to have_content("Learn Rails the Right Way")
          expect(page).to have_content("Learn Active Record Queries")
        end
      end
    end
  end
end
