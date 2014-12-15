class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_notices

  def set_notices
    @notices = Notice.all
    @oversea_websites = RESOURCES_CONSTANT::OVERSEA_WEBSITES
  end
end
