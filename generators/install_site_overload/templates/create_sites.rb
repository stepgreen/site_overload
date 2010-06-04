class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.integer :id
      t.string  :name, :null => false
      t.string  :fully_qualified_domain, :null => false
      t.boolean :is_default, :is_default => false
      t.boolean :is_live, :is_default => false
      t.text    :description
      t.integer :port
      t.string  :email_contact,:null => false
      t.string  :email_reply_to, :null => false
      t.timestamps
    end
    
    if RAILS_ENV == 'production' then
      puts "Adding #{RAILS_ENV} default site"
      Site.create( :name => 'main', :is_default => true, :fully_qualified_domain => 'www.sitedomain', :description => 'main site', :is_live => true, :email_contact => 'contact@sitedomain', :email_reply_to => 'no-reply@sitedomain' )
    elsif RAILS_ENV == 'staging' then  
      puts "Adding #{RAILS_ENV} default site"
      Site.create( :name => 'main', :is_default => true, :fully_qualified_domain => 'staging.sitedomain', :description => 'main site', :is_live => true, :email_contact => 'contact@staging.sitedomain', :email_reply_to => 'no-reply@staging.sitedomain' )
    elsif RAILS_ENV == 'test' then
      puts "Adding #{RAILS_ENV} default site"
      Site.create( :name => 'main', :is_default => true, :fully_qualified_domain => 'test.host', :description => 'main site', :is_live => true, :email_contact => 'contact@test.host', :email_reply_to => 'no-reply@test.host' )
    else
      puts "Adding #{RAILS_ENV} default site"
      Site.create( :name => 'main', :is_default => true, :fully_qualified_domain => 'localhost', :description => 'main site', :is_live => true, :email_contact => 'contact@localhost', :email_reply_to => 'no-reply@localhost' )
    end
  end

  def self.down
    drop_table :sites
  end
end
