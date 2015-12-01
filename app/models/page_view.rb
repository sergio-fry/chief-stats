class PageView < ActiveRecord::Base
  scope :today, lambda { where("created_at > ?", Time.now.beginning_of_day ) }
end
