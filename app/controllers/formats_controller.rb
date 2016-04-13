class FormatsController < ApplicationController
  def index
    formats = FormatService.prepare_formats(params[:format])
    if formats && formats.present?
      render json: formats,  status: :ok
    else
      render json: { error: 'No formats for this file' }, status: :not_acceptable
    end
  end
end
