class Session < ActiveRecord::Base
  has_many :page_views
end
