class Ride < ApplicationRecord
  before_save :geocode_endpoints

  belongs_to :user

  validates :seats, presence: true
  validates :seats, inclusion: {in: (1..8).to_a}

  validates :departure_time, presence: true
  validates :to_address, presence: true
  validates :from_address, presence: true
  # validates :from_lng, presence: true
  # validates :from_lat, presence: true
  # validates :to_lng, presence: true
  # validates :to_lat, presence: true

  def geocode_endpoints
    if from_address
      geocoded = Geocoder.search(from_address).first
      if geocoded
        self.from_lat = geocoded.latitude
        self.from_lng = geocoded.longitude
      end
    end

    # Repeat for destination
    if to_address
      geocoded = Geocoder.search(to_address).first
      if geocoded
        self.to_lat = geocoded.latitude
        self.to_lng = geocoded.longitude
      end
    end
  end
end
