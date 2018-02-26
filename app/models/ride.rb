class Ride < ApplicationRecord
  belongs_to :user

  validates :seats, presence: true
  validates :seats, inclusion: {in: (1..8).to_a}

  validates :departure_time, presence: true
  validates :from_lng, presence: true
  validates :from_lat, presence: true
  validates :to_lng, presence: true
  validates :to_lat, presence: true

end
