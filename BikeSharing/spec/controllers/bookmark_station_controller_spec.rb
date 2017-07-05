require 'rails_helper'

RSpec.describe BookmarkStationController, type: :controller do

  describe "GET #unbookmark" do
    it "returns http success" do
      get :unbookmark
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #bookmark" do
    it "returns http success" do
      get :bookmark
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #list" do
    it "returns http success" do
      get :list
      expect(response).to have_http_status(:success)
    end
  end

end
