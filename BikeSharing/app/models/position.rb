class Position < ApplicationRecord
  # For now, used on Station only
  belongs_to :imageable, polymorphic: true
end
