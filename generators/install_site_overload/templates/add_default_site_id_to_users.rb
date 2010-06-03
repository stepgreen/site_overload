class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    add_column  :<%= file_name %>s, :default_site_id, :integer
  end

  def self.down
    remove_column :<%= file_name %>s, :default_site_id
  end
end
