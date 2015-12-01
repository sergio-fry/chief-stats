class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_id
      t.string :domain
      t.integer :page_views_count
      t.text :referer
      t.cidr :ip

      t.timestamps null: false
    end

    add_index :sessions, :session_id, unique: true

    add_column :page_views, :session_id, :integer
    add_index :page_views, :session_id
  end
end
