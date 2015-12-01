class Client < ActiveRecord::Base
  include StatsHelpers
  has_many :sessions
end
