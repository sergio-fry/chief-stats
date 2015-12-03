class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :time_zone_shift

  private

  def time_zone_shift
    # Москва
    3
  end

  alias :tz :time_zone_shift
end
