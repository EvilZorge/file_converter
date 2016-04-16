class UsersController < ApplicationController
  before_action :authenticate_user!

  def files_history
    respond_to do |format|
      format.html { render 'users/files_history' }
    end
  end
end
