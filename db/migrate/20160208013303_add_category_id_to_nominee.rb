class AddCategoryIdToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :category_id, :integer
  end
end
