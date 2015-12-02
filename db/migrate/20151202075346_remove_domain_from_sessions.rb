class RemoveDomainFromSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :domain, :string
  end
end
