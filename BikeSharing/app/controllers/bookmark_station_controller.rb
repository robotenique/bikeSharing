class BookmarkStationController < ApplicationController
  def unbookmark
  end

  def bookmark
  end

  def list
    @bookmark_stations = BookmarkStation.all
  end

  def list_rank
    @ranked_bookmark_stations = BookmarkedRank.new.get_rank
  end
end
