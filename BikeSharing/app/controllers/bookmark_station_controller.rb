class BookmarkStationController < ApplicationController
  def unbookmark
  end

  def bookmark
    station = Station.find_by(name: params[:station_name])
    user    = User.find(current_user.id)
    if BookmarkStation.find_by(user: user, station: station)
      @ret_message = "Already bookmarked"
      return
    end
    b = BookmarkStation.new
    b.station = station
    b.user = user
    b.save!
    @ret_message = "Bookmarked =)"
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
