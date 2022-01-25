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
end
