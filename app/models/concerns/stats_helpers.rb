module StatsHelpers
  extend ActiveSupport::Concern

  included do
    scope :today, lambda { |time_zone_shift=nil| where("created_at > ?", Time.zone.now.beginning_of_day ) }
  end
end
