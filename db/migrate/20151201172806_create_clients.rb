class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :cookie_id
      t.integer :sessions_count

      t.timestamps null: false
    end

    add_column :sessions, :client_id, :integer
  end
end
