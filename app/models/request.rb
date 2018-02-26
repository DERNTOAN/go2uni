class Request < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :stop_time, presence: true

  validates :from_lng, presence: true
  validates :from_lat, presence: true
  validates :to_lng, presence: true
  validates :to_lat, presence: true
end
