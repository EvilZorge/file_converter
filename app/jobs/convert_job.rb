class ConvertJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(id, extension)
    ConvertService.convert(id, extension)
  end
end
