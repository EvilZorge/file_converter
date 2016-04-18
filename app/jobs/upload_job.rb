class UploadJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(file_id, extension, url)
    UploadService.upload_from_url(file_id, extension, url)
  end
end
