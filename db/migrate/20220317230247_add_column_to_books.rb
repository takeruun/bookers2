class AddColumnToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :rate, :float, after: :user_id
  end
end
