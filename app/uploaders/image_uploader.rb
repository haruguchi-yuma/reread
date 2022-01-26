class ImageUploader < Shrine
  Attacher.validate do
    validate_max_size 5*1024*1024
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff]
    validate_extension %w[jpg jpeg png webp tiff tif]
  end
end
