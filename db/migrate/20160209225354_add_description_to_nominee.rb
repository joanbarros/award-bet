class AddDescriptionToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :description, :string
  end
end
