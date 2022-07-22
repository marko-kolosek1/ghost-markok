require 'rails_helper'

RSpec.describe "Users", type: :feature do

  let (:user) { FactoryBot.create(:user) }
  let (:stories) { FactoryBot.create_list(:story, 5, user_id: user.id) }

  describe "GET users#index" do
    it "shows user stories" do
      login_as(user, scope: :user)
      visit "/users/#{user.id}/stories"
      expect(page).to have_content("List of Stories")
    end
  end

  describe "GET users#show" do
    it "shows specific story" do
      login_as(user, scope: :user)
      story = stories.first
      visit "/users/#{user.id}/stories/#{story.id}"
      expect(page).to have_content("#{story.title}")
      expect(page).to have_content("#{story.content}")      
    end
  end  

  describe "GET stories#new" do
    it "shows create new story" do
      login_as(user, scope: :user)
      visit "/users/#{user.id}/stories/new"
      expect(page).to have_content("Create a New Story")
    end
  end

  describe "POST stories#create" do
    it "creates new story" do
      login_as(user, scope: :user)
      visit "/users/#{user.id}/stories/new"
      fill_in 'story_title', with: 'New Title'
      fill_in 'story_content', with: 'New Content'
      click_button('Submit')
      expect(page).to have_content("Story was successfully created.")
    end
  end

  describe "POST stories#create" do
    it "creates new story" do
      login_as(user, scope: :user)
      story = stories.first
      visit "/users/#{user.id}/stories/#{story.id}/edit"
      fill_in 'story_title', with: 'New Title'
      fill_in 'story_content', with: 'New Content'
      fill_in 'story_tag_list', with: 'random list of tags'      
      click_button('Submit')
      expect(page).to have_content("Story was successfully updated.")
    end
  end

  describe "DELETE stories#destroy" do
    it "deletes story" do
      login_as(user, scope: :user)
      story = stories.first
      visit "/users/#{user.id}/stories/#{story.id}"
        find("a", :text => "Delete story").click
      expect(page).to have_content("Story was successfully destroyed.")         
    end
  end

end
