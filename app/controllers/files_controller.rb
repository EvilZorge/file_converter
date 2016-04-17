class FilesController < ApplicationController
  # before_action :authenticate_user!
  def index
  end

  def upload
    file = UploadService.upload(params[:file], params[:extension_to], current_user, params[:uploaded_url]) if ExtensionService.check_extension(params[:file], params[:extension_to])
    if file
      render json: file, serializer: FileUploadSerializer,  status: :ok
    else
      render json: { error: 'Cannot convert file' }, status: :not_acceptable
    end
  end

  def file_info
    info = FileService.info_from_url(params[:url])
    if info
      render json: info,  status: :ok
    else
      render json: { error: 'Cannot get file info' }, status: :not_acceptable
    end
  end
end
