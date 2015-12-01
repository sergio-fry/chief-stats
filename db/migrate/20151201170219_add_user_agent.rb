class AddUserAgent < ActiveRecord::Migration
  def change
    add_column :sessions, :user_agent, :string
  end
end
