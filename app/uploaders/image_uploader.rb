# frozen_string_literal: true

require 'image_processing/mini_magick'
class ImageUploader < Shrine
  plugin :processing # allows hooking into promoting
  plugin :versions   # enable Shrine to handle a hash of files
  plugin :delete_raw # delete processed files after uploading

  process(:store) do |io, _context|
    versions = { original: io } # retain original

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)

      versions[:large]  = pipeline.resize_to_limit!(800, 800)
      versions[:medium] = pipeline.resize_to_limit!(400, 400)
      versions[:small]  = pipeline.resize_to_limit!(150, 150)
    end

    versions # return the hash of processed files
  end

  Attacher.validate do
    validate_max_size 5 * 1024 * 1024, message: 'サイズは5.0MB以内で選択してください'
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff],
                       message: 'の種類はjpeg png webp tiff のいずれかで選択してください'
    validate_extension %w[jpg jpeg png webp tiff tif],
                       message: 'の拡張子はjpg jpeg png webp tiff tifのいずれかで選択してください'
  end
end
