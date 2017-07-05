class AbstractRank
  # Child classes must return a sorted list of pairs (station_id, value). Order in desc way
  def get_rank
    return nil
  end
end