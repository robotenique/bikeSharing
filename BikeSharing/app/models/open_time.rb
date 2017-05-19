class OpenTime < ApplicationRecord
  @allowed_dow = [ "mon", "tue", "wed", "thu", "fri", "sat", "sun" ]

  def self.allowedDow
    @allowed_dow
  end

  validates :dow, inclusion: {in:  @allowed_dow}
end
