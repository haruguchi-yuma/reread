require 'rails_helper'

RSpec.describe Photo, type: :model do
  it "有効な状態であること" do
    photo = FactoryBot.build(:photo)
    expect(photo).to be_valid
  end

  it "5MB以上の画像であれば無効な状態であること" do
    photo = FactoryBot.build(:photo, :within_file_size)
    photo.valid?
    expect(photo.errors[:image]).not_to include("サイズは5.0MB以内で選択してください")

    over_size_photo = FactoryBot.build(:photo, :over_file_size)
    over_size_photo.valid?
    expect(over_size_photo.errors[:image]).to include("サイズは5.0MB以内で選択してください")
  end

  it "拡張子がjpg jpeg png webp tiff tif以外は無効な状態であること" do
    photo = FactoryBot.build(:photo, :pdf)
    photo.valid?
    expect(photo.errors[:image]).to include('の拡張子はjpg jpeg png webp tiff tifのいずれかで選択してください')
  end

  it "MINEタイプがimage/jpeg image/png image/webp image/tiff以外は無効な状態であること" do
    photo = FactoryBot.build(:photo, :pdf)
    photo.valid?
    expect(photo.errors[:image]).to include('の種類はjpeg png webp tiff のいずれかで選択してください')
  end

  it "写真が選択されていないと無効な状態であること" do
    photo = FactoryBot.build(:photo, image: nil)
    photo.valid?
    expect(photo.errors[:image]).to include('が選択されていません')
  end
  
end
