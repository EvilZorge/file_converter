class FilesController < ApplicationController
  # before_action :authenticate_user!
  def index
  end

  def upload
    file = ConvertService.upload(params[:file], params[:format_to], current_user)
    if file
      render json: file, serializer: FileUploadSerializer,  status: :ok
    else
      render json: { error: 'Cannot convert file' }, status: :not_acceptable
    end
  end
end
