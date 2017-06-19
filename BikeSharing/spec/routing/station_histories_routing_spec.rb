require "rails_helper"

RSpec.describe StationHistoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/station_histories").to route_to("station_histories#index")
    end

    it "routes to #new" do
      expect(:get => "/station_histories/new").to route_to("station_histories#new")
    end

    it "routes to #show" do
      expect(:get => "/station_histories/1").to route_to("station_histories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/station_histories/1/edit").to route_to("station_histories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/station_histories").to route_to("station_histories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/station_histories/1").to route_to("station_histories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/station_histories/1").to route_to("station_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/station_histories/1").to route_to("station_histories#destroy", :id => "1")
    end

  end
end
