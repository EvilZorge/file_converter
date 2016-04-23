class UploadJob < ActiveJob::Base
  queue_as :default

  def perform(file_id, extension, external)
    UploadService.upload_from_external_storage(file_id, extension, external)
  end
end
