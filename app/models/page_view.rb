class PageView < ActiveRecord::Base
  belongs_to :session, counter_cache: true, touch: true
  scope :today, lambda { where("created_at > ?", Time.now.beginning_of_day ) }
end
