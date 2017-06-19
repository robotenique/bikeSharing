require 'rails_helper'

RSpec.describe "station_histories/edit", type: :view do
  before(:each) do
    @station_history = assign(:station_history, StationHistory.create!(
      :free_slots => 1,
      :free_bikes => 1,
      :rate => 1.5,
      :citybik_station_id => "MyString"
    ))
  end

  it "renders the edit station_history form" do
    render

    assert_select "form[action=?][method=?]", station_history_path(@station_history), "post" do

      assert_select "input#station_history_free_slots[name=?]", "station_history[free_slots]"

      assert_select "input#station_history_free_bikes[name=?]", "station_history[free_bikes]"

      assert_select "input#station_history_rate[name=?]", "station_history[rate]"

      assert_select "input#station_history_citybik_station_id[name=?]", "station_history[citybik_station_id]"
    end
  end
end
