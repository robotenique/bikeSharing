class BookmarkStationController < ApplicationController
  def unbookmark
  end

  def bookmark
  end

  def list
    if user_signed_in?
      # The following line of code
      # find_by user_id: #{current_user.id}
      # returns only the first station...
      @bookmark_stations = BookmarkStation.find_by_sql "SELECT * FROM bookmark_stations WHERE \"user_id\" = #{current_user.id}"
    else
      @bookmark_stations = BookmarkStation.all
    end
  end

  def list_rank
    @ranked_bookmark_stations = BookmarkedRank.new.get_rank
  end
end
