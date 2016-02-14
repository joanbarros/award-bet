class AddAwardIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :award_id, :integer
  end
end
