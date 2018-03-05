class Ride < ApplicationRecord
  before_validation :geocode_endpoints
  before_validation :compute_duration_and_distance


  belongs_to :user
  has_many :offers
  has_many :requests, through: :offers
  has_many :passengers, through: :requests, source: :user
  validates :seats, presence: true
  validates :seats, inclusion: {in: (1..8).to_a}


  validates :direction, inclusion: {in: ["to", "from", nil]}

  validates :departure_time, presence: true

  validates :from_lng, presence: true
  validates :from_lat, presence: true
  validates :to_lng, presence: true
  validates :to_lat, presence: true

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

  def compute_duration_and_distance
    if(self.from_lat && self.from_lng && self.to_lat && self.to_lng)
      url_ride= "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{self.from_lat},#{self.from_lng}&destinations=#{self.to_lat},#{self.to_lng}&mode=driving&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
      distances_ride = JSON.parse(open(url_ride).read)
      unless distances_ride["rows"][0]["elements"][0]["status"] == "ZERO RESULTS"
        self.duration = distances_ride["rows"][0]["elements"][0]["duration"]["value"]
        self.distance = distances_ride["rows"][0]["elements"][0]["distance"]["value"]
      end
    else
      self.duration = 9999999
      self.distance = 9999999
    end
  end

end
