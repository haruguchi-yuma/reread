# frozen_string_literal: true

class ImageUploader < Shrine
  Attacher.validate do
    validate_max_size 5 * 1024 * 1024, message: "サイズは5.0MB以内で選択してください"
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff],
      message: "の種類はjpeg png webp tiff のいずれかで選択してください"
    validate_extension %w[jpg jpeg png webp tiff tif],
      message: "の拡張子はjpg jpeg png webp tiff tifのいずれかで選択してください"
  end
end
