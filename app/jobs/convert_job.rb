class ConvertJob < ActiveJob::Base
  queue_as :default

  def perform(id, upload_to)
    ConvertService.convert(id, upload_to)
  end
end
