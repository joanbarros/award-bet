class AddNameToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :name, :string
  end
end
