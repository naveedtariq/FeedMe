class AddRestaurantIdToFavorites < ActiveRecord::Migration
  def self.up
		add_column :favourite_restaurants, :restaurant_id, :integer
  end

  def self.down
		remove_column :favourite_restaurants, :restaurant_id
  end
end
