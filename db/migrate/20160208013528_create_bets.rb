class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|

      t.timestamps null: false
    end
  end
end
