class AddFacebookFieldsToUser < ActiveRecord::Migration
	def self.up
		add_column :users, :facebook_email, :string
		add_column :users, :facebook_city, :string
		add_column :users, :facebook_country, :string
	end

	def self.down
		remove_column :users, :facebook_country
		remove_column :users, :facebook_city
		remove_column :users, :facebook_email
	end
end
