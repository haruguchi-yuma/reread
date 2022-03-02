# frozen_string_literal: true

class User < ApplicationRecord
  has_many :books, dependent: :destroy

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    image_url = auth_hash[:info][:image]

    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.image_url = image_url
    end
  end

  def store_credentials_in_cache(auth_hash)
    expires_at = auth_hash.credentials.expires_at
    Rails.cache.write('expires_at', expires_at)
    Rails.cache.fetch(uid, expires_in: expires_at) do
      auth_hash.credentials.token
    end
    Rails.cache.write(uid + id.to_s, auth_hash.credentials.refresh_token)
  end
end
