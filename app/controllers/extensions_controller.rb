class ExtensionsController < ApplicationController
  def index
    extensions = ExtensionService.prepare_extensions(params[:format])
    if extensions && extensions.present?
      render json: extensions,  status: :ok
    else
      render json: { error: t('.error') }, status: :not_acceptable
    end
  end
end
