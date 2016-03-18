# frozen_string_literal: true
class AddLatitudeLongitudeLocationToProducts < ActiveRecord::Migration
  def change
    add_column :products, :latitude, :float
    add_column :products, :longitude, :float
    add_column :products, :location, :string
  end
end
