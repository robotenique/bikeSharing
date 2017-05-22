class OpenTime < ApplicationRecord
  @allowed_dow = [ "bday", "holiday", "sat", "sun" ]

  def self.allowed_dow
    @allowed_dow
  end

  validates :dow, inclusion: {in:  @allowed_dow}

  belongs_to :station
end
