class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #:confirmable, :lockable, :timeoutable and :omniauthable
  # after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :photo, PhotoUploader

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
