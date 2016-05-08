class ConvertJob < ActiveJob::Base
  queue_as :default

  def perform(id, upload_to, email)
    ConvertService.convert(id, upload_to, email)
  end
end
