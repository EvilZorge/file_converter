class FilesController < ApplicationController
  def index
  end

  def upload
    file = UploadService.upload(params, current_user) if ExtensionService.check_extension(params[:file], params[:extension_to])
    if file
      render json: file, serializer: FileUploadSerializer, status: :ok
    else
      render json: { error: t('.error') }, status: :not_acceptable
    end
  end

  def file_info
    info = FileService.info_from_url(params[:url])
    if info
      render json: info, status: :ok
    else
      render json: { error: t('.error') }, status: :not_acceptable
    end
  end

  def check_state
    state = FileService.check_state(params[:id])
    if state
      render json: state, status: :ok
    else
      render json: { error: t('.error') }, status: :not_acceptable
    end
  end
end
