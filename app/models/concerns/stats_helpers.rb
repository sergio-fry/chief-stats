module StatsHelpers
  extend ActiveSupport::Concern

  included do
    scope :today, lambda { where("created_at > ?", Time.now.beginning_of_day ) }
  end
end
