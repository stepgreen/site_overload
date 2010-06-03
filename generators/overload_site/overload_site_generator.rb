class OverloadSiteGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Site folder(s)
      m.directory File.join( "sites", file_name )
      # site content folders
      m.directory File.join( "sites", file_name, "app" )
      m.directory File.join( "sites", file_name, "app", "controllers" )
      m.directory File.join( "sites", file_name, "app", "views" )
      m.directory File.join( "sites", file_name, "app", "views", "layouts" )
      m.directory File.join( "sites", file_name, "public" )
      m.directory File.join( "sites", file_name, "public", "images" )
      m.directory File.join( "sites", file_name, "public", "javascripts" )
      m.directory File.join( "sites", file_name, "public", "stylesheets" )
          
      unless options[:skip_migration]
        migration_template = RAILS_GEM_VERSION.to_i == 1 ? 'old_migration.rb' : 'migration.rb'
        
        m.migration_template(
          migration_template, 'db/migrate', 
          :assigns => {
            :migration_name => "AddDataForSite#{class_name.gsub(/::/, '')}ToSites",
            :attributes     => attributes
          }, 
          :migration_file_name => "add_data_for_site_#{file_path.gsub(/\//, '_')}_to_sites"
        )
      end
      
    end
  end
end
