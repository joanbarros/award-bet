class AddFieldsToTables < ActiveRecord::Migration
  def change
    add_column :bets, :user_id, :integer
    add_column :bets, :amount, :decimal
    add_column :bets, :nominee_id, :integer
    
  end
end
