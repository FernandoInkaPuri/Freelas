class ApplicationController < ActionController::Base
  def authenticate_person
    return if professional_signed_in? || user_signed_in?

    redirect_to root_path
  end
end
