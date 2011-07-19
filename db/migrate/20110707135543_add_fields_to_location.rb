class AddFieldsToLocation < ActiveRecord::Migration
  def self.up
		add_column :locations, :apt, :integer
		add_column :locations, :is_home_address, :boolean
		add_column :locations, :active, :boolean
  end

  def self.down
		remove_column :locations, :apt
		remove_column :locations, :is_home_address
		remove_column :locations, :active
  end
end
