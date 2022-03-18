class AddColumnCategoryIdToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :category_id, :integer, after: :rate
  end
end
