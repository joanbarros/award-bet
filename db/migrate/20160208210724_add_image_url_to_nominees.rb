class AddImageUrlToNominees < ActiveRecord::Migration
  def change
    add_column :nominees, :image_url, :string
  end
end
