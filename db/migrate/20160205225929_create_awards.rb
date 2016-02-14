class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name
      t.text :description
      t.boolean :active
      t.datetime :closing_date

      t.timestamps null: false
    end
  end
end
