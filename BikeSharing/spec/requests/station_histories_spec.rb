require 'rails_helper'

RSpec.describe "StationHistories", type: :request do
  describe "GET /station_histories" do
    it "works! (now write some real specs)" do
      get station_histories_path
      expect(response).to have_http_status(200)
    end
  end
end
