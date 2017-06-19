require 'rails_helper'

RSpec.describe "station_histories/index", type: :view do
  before(:each) do
    assign(:station_histories, [
      StationHistory.create!(
        :free_slots => 2,
        :free_bikes => 3,
        :rate => 4.5,
        :citybik_station_id => "Citybik Station"
      ),
      StationHistory.create!(
        :free_slots => 2,
        :free_bikes => 3,
        :rate => 4.5,
        :citybik_station_id => "Citybik Station"
      )
    ])
  end

  it "renders a list of station_histories" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => "Citybik Station".to_s, :count => 2
  end
end
