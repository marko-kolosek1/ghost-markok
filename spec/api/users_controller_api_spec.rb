require 'rails_helper'
RSpec.describe Api::V1::UsersController do
  before :each do
    @user = FactoryBot.create(:user)
    @api_key = FactoryBot.create(:api_key)
  end

  describe "GET #index" do
    it "get users without providing token" do
      get '/api/v1/users'
      expect(response).to have_http_status(:unauthorized)
    end
    it "get users with wrong token" do
      get '/api/v1/users', headers: {Authorization: "Token token=wrongtoken1234567"}
      expect(response).to have_http_status(:unauthorized)
    end    
    it "get users with correct token" do
      get '/api/v1/users', headers: {Authorization: "Token token=#{@api_key.access_token}"}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "see user stories without access token" do
      get "/api/v1/users/#{@user.id}"
      expect(response).to have_http_status(:unauthorized)      
    end
    it "see user stories without access token" do
      get "/api/v1/users/#{@user.id}", headers: {Authorization: "Token token=#{@api_key.access_token}"}
      expect(response).to have_http_status(:unauthorized)
    end
    it "see user stories with wrong access token" do
      get "/api/v1/users/#{@user.id}", headers: {Authorization: "Token token=wrongtoken1234567"}
      expect(response).to have_http_status(:unauthorized)
    end    
  end
end
