class ChangeDataTypeForSessions < ActiveRecord::Migration
  def self.up
    change_table :sessions do |t|
      t.change :data, :text
    end
  end

  def self.down
    change_table :sessions do |t|
      t.change :data, :text
    end
  end
end
