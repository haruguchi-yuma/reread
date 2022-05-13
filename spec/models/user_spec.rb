# frozen_string_literal: true

require 'ostruct'
require 'json'
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_or_create_from_auth_hash!' do
    it '有効な引数が渡されたときuserが見つかること' do
      user = create(:user)
      auth_hash = { provider: user.provider, uid: user.uid, info: { image: user.image_url } }
      expect(User.find_or_create_from_auth_hash!(auth_hash)).to eq user
    end

    it '無効な引数が渡された場合エラーが出ること' do
      user = build(:user)
      auth_hash = { provider: 'google_oauth2', uid: nil, info: { image: user.image_url } }
      expect { User.find_or_create_from_auth_hash!(auth_hash) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe '#store_credentials_in_cache' do
    before do
      hash = {
        credentials: {
          expires_at: (Time.zone.now + 1.hour).to_i,
          token: 'hoge',
          refresh_token: 'bar'
        }
      }
      @auth_hash = JSON.parse(hash.to_json, object_class: OpenStruct)
    end

    it 'キャッシュに保存される' do
      user = create(:user)
      user.store_credentials_in_cache(@auth_hash)
      expect(Rails.cache.read("#{user.uid}expires_at")).to eq @auth_hash.credentials.expires_at
      expect(Rails.cache.read(user.uid)).to eq @auth_hash.credentials.token
      expect(Rails.cache.read(user.uid + user.id.to_s)).to eq @auth_hash.credentials.refresh_token
    end
  end

  describe '#delete_refresh_token_in_cache' do
    before do
      @user = create(:user)
      hash = {
        credentials: {
          expires_at: (Time.zone.now + 1.hour).to_i,
          token: 'hoge',
          refresh_token: 'bar'
        }
      }
      auth_hash = JSON.parse(hash.to_json, object_class: OpenStruct)
      Rails.cache.write(@user.uid + @user.id.to_s, auth_hash.credentials.refresh_token)
    end

    it 'キャッシュに保存したリフレッシュトークンが削除されること' do
      expect(Rails.cache.exist?(@user.uid + @user.id.to_s)).to be_truthy

      @user.delete_refresh_token_in_cache
      expect(Rails.cache.exist?(@user.uid + @user.id.to_s)).to be_falsey
    end
  end
end
