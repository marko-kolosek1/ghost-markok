require 'rails_helper'

RSpec.describe "Users", type: :feature do

  let (:user) { FactoryBot.create(:user) }

  describe "GET users#index" do
    it "not logged in" do
      visit "/users"
      expect(page).to have_text("Log in")
    end
    it "logged in" do
      login_as(user, scope: :user)
      visit "/users"
      expect(page).to have_text("Team")
    end
  end

  describe "GET users#show" do
    it "shows user profile page" do
      login_as(user, scope: :user)      
      visit "/users/#{user.id}"
      expect(page).to have_content("#{user.first_name}")
      expect(page).to have_content("#{user.last_name}")
      expect(page).to have_content("#{user.email}")
    end
  end

  describe "GET users#edit" do
    it "shows edit password page" do
      login_as(user, scope: :user)      
      visit "/users/#{user.id}/edit"
      expect(page).to have_content("Old password")
      expect(page).to have_content("New password")      
    end
  end

  describe "POST users#update" do
    it "updates users first name" do
      login_as(user, scope: :user)      
      visit "/users/#{user.id}"
      fill_in 'user_first_name', with: 'New Name'
      fill_in 'user_last_name', with: 'New Surname'
      fill_in 'user_email', with: 'newemail@email.com'
      fill_in 'user_bio', with: 'Completely new user biography'
      click_button('Save')
      expect(page).to have_content('User was successfully updated!')
    end
  end

  describe "POST users#create" do
    it "creates new user" do
      visit "/users/sign_up"
      fill_in 'user_email', with: 'newuser@email.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button('Sign up')
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  describe "POST users#update_password" do
    it 'updates user password' do
      login_as(user, scope: :user)      
      visit "/users/#{user.id}/edit"
      fill_in 'user_current_password', with: user.password
      fill_in 'user_password', with: 'newpassword'
      fill_in 'user_password_confirmation', with: 'newpassword'
      click_button('Update User')
      expect(page).to have_content('Password successfully updated!')
    end
  end

  describe "DELETE users#destroy" do
    it 'delete user' do
      login_as(user, scope: :user)      
      visit "/users/#{user.id}"
      click_button 'Remove user'
      within('#deleteModal') do
        find("a", :text => "Yes").click
      end
      expect(page).to have_content('User was successfully destroyed.')
    end
  end
end
