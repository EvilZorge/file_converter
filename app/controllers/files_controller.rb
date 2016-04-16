class FilesController < ApplicationController
  # before_action :authenticate_user!
  def index
  end

  def upload
    file = ConvertService.upload(params[:file], params[:extension_to], current_user) if ExtensionService.check_extension(params[:file], params[:extension_to])
    if file
      render json: file, serializer: FileUploadSerializer,  status: :ok
    else
      render json: { error: 'Cannot convert file' }, status: :not_acceptable
    end
  end
end
