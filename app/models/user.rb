# frozen_string_literal: true

class User < ApplicationRecord
  has_many :books, dependent: :destroy

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    image_url = auth_hash[:info][:image]

    find_or_create_by!(provider: provider, uid: uid) do |user|
      user.image_url = image_url
    end
  end

  def store_credentials_in_cache(auth_hash)
    expires_at = auth_hash.credentials.expires_at
    Rails.cache.write("#{uid}expires_at", expires_at)
    Rails.cache.write(uid, auth_hash.credentials.token)
    Rails.cache.write(uid + id.to_s, auth_hash.credentials.refresh_token)
  end
end
