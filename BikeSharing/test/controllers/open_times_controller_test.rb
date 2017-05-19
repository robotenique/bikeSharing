require 'test_helper'

class OpenTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @open_time = open_times(:one)
  end

  test "should get index" do
    get open_times_url
    assert_response :success
  end

  test "should get new" do
    get new_open_time_url
    assert_response :success
  end

  test "should create open_time" do
    assert_difference('OpenTime.count') do
      post open_times_url, params: { open_time: { close: @open_time.close, dow: @open_time.dow, open: @open_time.open, station_id: @open_time.station_id } }
    end

    assert_redirected_to open_time_url(OpenTime.last)
  end

  test "should show open_time" do
    get open_time_url(@open_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_open_time_url(@open_time)
    assert_response :success
  end

  test "should update open_time" do
    patch open_time_url(@open_time), params: { open_time: { close: @open_time.close, dow: @open_time.dow, open: @open_time.open, station_id: @open_time.station_id } }
    assert_redirected_to open_time_url(@open_time)
  end

  test "should destroy open_time" do
    assert_difference('OpenTime.count', -1) do
      delete open_time_url(@open_time)
    end

    assert_redirected_to open_times_url
  end
end
