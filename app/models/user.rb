class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #:confirmable, :lockable, :timeoutable and :omniauthable
  # after_create :send_welcome_email
  has_many :rides
  has_many :requests
  has_many :offers, through: :requests
  has_many :passenger_journeys, through: :offers, source: :ride
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :photo, PhotoUploader

  def next_ride
    driver = rides.where('departure_time > ?', Time.now ).order(:departure_time).first
    passenger = passenger_journeys.where('departure_time > ?', Time.now ).order(:departure_time).first
    [driver, passenger].compact.sort_by(&:departure_time).first
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
