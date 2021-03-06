class BookmarkedRank < AbstractRank
  def get_rank
    bookmarked_rank = Hash.new
    BookmarkStation.all.each do |b|
      if bookmarked_rank[b.station.id] != nil
        bookmarked_rank[b.station.id] = bookmarked_rank[b.station.id] + 1
      else
        bookmarked_rank.append_merge! b.station.id, 1
      end
    end
    bookmarked_rank.sort_by{|_key, value| value}.reverse
  end

  def print_rank
    get_rank.each do |bookmarked_rank|
      puts "estacao #{bookmarked_rank[0]} - #{Station.find(bookmarked_rank[0]).name} tem #{bookmarked_rank[1]} bookmarks"
    end
  end
end