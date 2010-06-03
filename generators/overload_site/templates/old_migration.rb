class <%= migration_name %> < ActiveRecord::Migration
  def self.up
  # Make sure that you set the FQD's correctly for each environment
    puts "Adding #{RAILS_ENV} default site"
    if RAILS_ENV == 'production' then
      s = Site.new
      s.name = '<%= file_name %>'
      s.is_default = false
      s.fully_qualified_domain = '<%= file_name %>'
      s.description = '<%= file_name %>'
      s.port = nil
      # if you want the site to be live immediately after migrating, set this to true
      s.is_live = false
      s.save
    elsif RAILS_ENV == 'staging' then  
      s = Site.new
      s.name = '<%= file_name %>'
      s.is_default = false
      s.fully_qualified_domain = 'staging.<%= file_name %>'
      s.description = '<%= file_name %>'
      s.port = nil
      # if you want the site to be live immediately after migrating, set this to true
      s.is_live = false
      s.save
    elsif RAILS_ENV == 'test' then
      s = Site.new
      s.name = '<%= file_name %>'
      s.is_default = false
      s.fully_qualified_domain = 'test.<%= file_name %>'
      s.description = '<%= file_name %>'
      s.port = nil
      # if you want the site to be live immediately after migrating, set this to true
      s.is_live = false
      s.save
    elsif RAILS_ENV == 'development'
      s = Site.new
      s.name = '<%= file_name %>'
      s.is_default = false
      s.fully_qualified_domain = '<%= file_name %>.dev'
      s.description = '<%= file_name %>'
      s.port = nil
      # if you want the site to be live immediately after migrating, set this to true
      s.is_live = false
      s.save
    end  
  end

  def self.down
  end
end
