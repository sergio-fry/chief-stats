class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|
      t.text :url
      t.text :referer

      t.timestamps null: false
    end
  end
end
