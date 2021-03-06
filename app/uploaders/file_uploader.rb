# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Rails::Helper

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "tmp/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  def download_from_url!(uri, headers)
    processed_uri = process_uri(uri)
    file = RemoteFile.new(processed_uri, headers)
    raise CarrierWave::DownloadError, "trying to download a file which is not served over HTTP" unless file.http?
    cache!(file)
    self
  end

  def filename
    original_filename
  end

  def uploaded_filename
    model.read_attribute mounted_as
  end
end
