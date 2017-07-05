class BookmarkStation < ApplicationRecord
  belongs_to :user
  belongs_to :station
end
