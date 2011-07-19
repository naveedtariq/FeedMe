class CreateLocations < ActiveRecord::Migration
	def self.up
		create_table :locations do |t|
			t.integer :user_id
			t.string :name
			t.string :street
			t.string :city
			t.string :state
			t.string :zip
			t.string :country
			t.float :lat
			t.float :lng
			t.string :raw_address
			t.string :time_zone

			t.timestamps
		end
	end

	def self.down
		drop_table :locations
	end
end
