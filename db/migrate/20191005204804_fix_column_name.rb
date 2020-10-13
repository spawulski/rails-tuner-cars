# frozen_string_literal: true

class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :listings, :location, :province
  end
end
