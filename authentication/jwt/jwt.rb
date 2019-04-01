class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end

class User < ApplicationRecord
  has_secure_password # from gem bcrypt, 
  # provide user.authenticate(password)
  mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  class << self
     # should move into common module
    def find_cached(user_id)
      user_key = "User_#{user_if}"
      Rails.cache.fetch(user_key){
        prepare_cache(id)
      }
    end

    def prepare_cache(id)
      # this will be overwiten by including class
      # for example, for eager loading
      find_by(id:user_id)
    end
  end
end
