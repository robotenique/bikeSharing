class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 reverse_geocoded_by :latitude, :longitude
 after_validation :reverse_geocode
  attr_accessor :latitude, :longitude, :address
end
