class Session < ActiveRecord::Base
  include StatsHelpers

  has_many :page_views
end
