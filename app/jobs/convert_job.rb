class ConvertJob < ActiveJob::Base
  queue_as :default

  def perform(id, extension, upload_to)
    ConvertService.convert(id, extension, upload_to)
  end
end
