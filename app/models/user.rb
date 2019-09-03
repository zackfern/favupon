class User < ApplicationRecord
  class << self
    # Public: Find or create a User record based off of the Omniauth auth hash.
    # Returns User
    def find_or_create_from_auth_hash(auth_hash)
      record = self.find_or_create_by(twitter_uid: auth_hash[:uid], access_token: auth_hash[:credentials][:token])

      unless record.persisted?
        record.update_attribute(access_secret: auth_hash[:credentials][:secret])
      end

      record
    end
  end
end
