class CreatePageViews < ActiveRecord::Migration[6.1]
  def change
    create_table :page_views do |t|
      t.integer :book_id

      t.timestamps
    end
  end
end
