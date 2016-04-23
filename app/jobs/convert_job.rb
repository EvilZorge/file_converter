class ConvertJob < ActiveJob::Base
  queue_as :default

  def perform(id, extension)
    ConvertService.convert(id, extension)
  end
end
