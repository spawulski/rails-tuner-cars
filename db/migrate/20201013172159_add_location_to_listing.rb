class AddLocationToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :location, :string
  end
end
