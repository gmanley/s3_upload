# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  include Sprockets::Helpers::RailsHelper

  process :set_content_type

  version :huge do
    process resize_to_fit: [1024, 1024]
  end

  version :large do
    process resize_to_fit: [640, 640]
  end

  version :medium do
    process resize_to_fit: [320, 320]
  end

  version :small do
    process resize_to_fit: [160, 160]
  end

  version :large_square do
    process resize_to_fill: [200, 200]
  end

  version :small_square do
    process resize_to_fill: [100, 100]
  end

  def store_dir
    File.join('uploads', 'images', model.id.to_s)
  end

  def default_url
    image_path("placeholder.png")
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end