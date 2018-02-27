class Ride < ApplicationRecord
  geocoded_by :from_address, :latitude  => :from_lat, :longitude => :from_lng
  geocoded_by :to_address, :latitude  => :to_lat, :longitude => :to_lng
  after_validation :geocode

  belongs_to :user

  validates :seats, presence: true
  validates :seats, inclusion: {in: (1..8).to_a}

  validates :departure_time, presence: true
  validates :from_lng, presence: true
  validates :from_lat, presence: true
  validates :to_lng, presence: true
  validates :to_lat, presence: true

end
