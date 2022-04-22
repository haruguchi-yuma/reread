# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  it '有効な状態であること' do
    photo = FactoryBot.build(:photo)
    expect(photo).to be_valid
  end

  it '5MB以上の画像であれば無効な状態であること' do
    photo = FactoryBot.build(:photo, :with_small_jpeg)
    photo.valid?
    expect(photo.errors[:image]).not_to include('サイズは5.0MB以内で選択してください')

    over_size_photo = FactoryBot.build(:photo, :with_large_jpeg)
    over_size_photo.valid?
    expect(over_size_photo.errors[:image]).to include('サイズは5.0MB以内で選択してください')
  end

  it '拡張子がjpg jpeg png webp tiff tif以外は無効な状態であること' do
    photo = FactoryBot.build(:photo, :with_pdf)
    photo.valid?
    expect(photo.errors[:image]).to include('の拡張子はjpg jpeg png webp tiff tifのいずれかで選択してください')
  end

  it 'MIMEタイプがimage/jpeg image/png image/webp image/tiff以外は無効な状態であること' do
    photo = FactoryBot.build(:photo, :with_pdf)
    photo.valid?
    expect(photo.errors[:image]).to include('の種類はjpeg png webp tiff のいずれかで選択してください')
  end

  it '写真が選択されていないと無効な状態であること' do
    photo = FactoryBot.build(:photo, image: nil)
    photo.valid?
    expect(photo.errors[:image]).to include('が選択されていません')
  end

  it 'メモが入力されていなくても有効なこと' do
    photo = FactoryBot.build(:photo, note: nil)
    expect(photo).to be_valid
  end

  it 'メモに140文字入力されている場合は有効な状態であること' do
    photo = FactoryBot.build(:photo, note: 'a' * 140)
    expect(photo).to be_valid
  end

  it 'メモに141文字以上入力されている場合は無効な状態であること' do
    photo = FactoryBot.build(:photo, note: 'a' * 141)
    photo.valid?
    expect(photo.errors[:note]).to include('は140文字以内で入力してください')
  end
end
