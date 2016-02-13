class AddWinnerToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :winner, :boolean
  end
end
