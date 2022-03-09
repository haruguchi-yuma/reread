require 'shrine'
require "shrine/storage/file_system"
require "cloudinary"
require "shrine/storage/cloudinary"

if Rails.env.production?
  Cloudinary.config(
    cloud_name: Rails.application.credentials.cloudinary[:cloud_name],
    api_key:    Rails.application.credentials.cloudinary[:api_key],
    api_secret: Rails.application.credentials.cloudinary[:api_secret]
  )
  Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(prefix: "cache"),
  store: Shrine::Storage::Cloudinary.new(prefix: "reread")
}
else
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads")
  }
end



Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type
