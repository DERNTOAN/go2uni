class Request < ApplicationRecord
  has_many :offers
  belongs_to :user
  before_validation :geocode_endpoints

  validates :from_lng, presence: true
  validates :from_lat, presence: true
  validates :to_lng, presence: true
  validates :to_lat, presence: true

  validates :start_time, presence: true
  validates :stop_time, presence: true

  validates :uni, inclusion: {in: ["thuebingen", "aachen", "bayreuth"]}

  validates :direction, inclusion: {in: ["to", "from", nil]}

  private

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
