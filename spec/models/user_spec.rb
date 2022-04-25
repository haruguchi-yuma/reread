# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User.find_or_create_from_auth_hash!' do
    it '有効な引数が渡されたときuserが見つかること' do
      user = create(:user)
      auth_hash = {provider: user.provider, uid: user.uid, info: {image: user.image_url}}
      expect(User.find_or_create_from_auth_hash!(auth_hash)).to eq user
    end

    it '無効な引数が渡された場合エラーが出ること' do
      user = build(:user)
      auth_hash = {provider: 'twitter_oauth', uid: user.uid, info: {image: user.image_url}}
      expect{User.find_or_create_from_auth_hash!(auth_hash)}.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
