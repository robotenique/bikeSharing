class Position < ApplicationRecord
  belongs_to :imageable, polymorphic: true
end
