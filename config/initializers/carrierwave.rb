module CarrierWave
  module Uploader
    module Download
      class RemoteFile
        def initialize(uri, headers = {})
          @uri = uri
          @headers = headers
        end

      private

        def file
          if @file.blank?
            @file =
              if @headers.present?
                Kernel.open(@uri.to_s, @headers)
              else
                Kernel.open(@uri.to_s, "User-Agent" => "CarrierWave/#{CarrierWave::VERSION}")
              end
            @file = @file.is_a?(String) ? StringIO.new(@file) : @file
          end
          @file

        rescue StandardError => e
          raise CarrierWave::DownloadError, "could not download file: #{e.message}"
        end
      end
    end
  end
end
