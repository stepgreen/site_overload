class AddDefaultSiteIdToUsers < ActiveRecord::Migration
  def self.up
    add_column  :users, :default_site_id, :integer
  end

  def self.down
    remove_column :users, :default_site_id
  end
end
