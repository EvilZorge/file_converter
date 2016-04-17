class ConvertJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(file, extension)
    ConvertService.convert(file, extension)
  end
end
