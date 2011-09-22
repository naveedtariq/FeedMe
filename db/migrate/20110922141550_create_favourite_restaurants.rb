class CreateFavouriteRestaurants < ActiveRecord::Migration
  def self.up
    create_table :favourite_restaurants do |t|
			t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :favourite_restaurants
  end
end
