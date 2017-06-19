require 'rails_helper'

RSpec.describe "station_histories/show", type: :view do
  before(:each) do
    @station_history = assign(:station_history, StationHistory.create!(
      :free_slots => 2,
      :free_bikes => 3,
      :rate => 4.5,
      :citybik_station_id => "Citybik Station"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/Citybik Station/)
  end
end
