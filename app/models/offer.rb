class Offer < ApplicationRecord
  before_save :compute_duration_and_distance
  belongs_to :ride
  belongs_to :request

  def compute_duration_and_distance
    url_walk_to_car= "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{self.request.from_lat},#{self.request.from_lng}&destinations=#{self.ride.from_lat},#{self.ride.from_lng}&mode=walking&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
    distances_walk_to_car = JSON.parse(open(url_walk_to_car).read)

    url_walk_to_dest= "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{self.ride.to_lat},#{self.ride.to_lng}&destinations=#{self.request.to_lat},#{self.request.to_lng}&mode=walking&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
    distances_walk_to_dest = JSON.parse(open(url_walk_to_dest).read)

    unless distances_walk_to_car["rows"][0]["elements"][0]["status"] == "ZERO RESULTS"
      self.duration_to_car = distances_walk_to_car["rows"][0]["elements"][0]["duration"]["value"]
      self.distance_to_car = distances_walk_to_car["rows"][0]["elements"][0]["distance"]["value"]
    end

    unless distances_walk_to_dest["rows"][0]["elements"][0]["status"] == "ZERO RESULTS"
      self.duration_to_dest = distances_walk_to_dest["rows"][0]["elements"][0]["duration"]["value"]
      self.distance_to_dest = distances_walk_to_dest["rows"][0]["elements"][0]["distance"]["value"]
    end
  end


end
