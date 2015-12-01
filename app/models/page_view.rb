class PageView < ActiveRecord::Base
  include StatsHelpers

  belongs_to :session, counter_cache: true, touch: true
end
