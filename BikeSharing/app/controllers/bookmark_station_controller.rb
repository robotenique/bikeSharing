class BookmarkStationController < ApplicationController
  def unbookmark
  end

  def bookmark
  end

  def list
    @bookmark_stations = BookmarkStation.all
  end
end
