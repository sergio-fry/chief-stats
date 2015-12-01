class Session < ActiveRecord::Base
  include StatsHelpers

  has_many :page_views
  belongs_to :client, counter_cache: true, touch: true
end
