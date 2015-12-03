class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :time_zone_wrapper
  helper_method :time_zone_shift, :tzs, :time_zone, :tz

  private

  def time_zone_shift
    3
  end

  alias :tzs :time_zone_shift

  def time_zone
    "Moscow"
  end

  alias :tz :time_zone

  def time_zone_wrapper
    Time.use_zone time_zone do
      yield
    end
  end
end
