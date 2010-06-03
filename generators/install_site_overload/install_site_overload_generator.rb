class InstallSiteOverloadGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Site folder(s)
      m.directory File.join( "sites" )
      
      m.template 'site_overload.rb', File.join('lib', "site_overload.rb")
      
      unless options[:skip_migration]
        migration_template = 'create_sites.rb'

         m.migration_template(
           migration_template, 'db/migrate',
           :migration_file_name => "create_sites"
         )

          # force sleep so we don't clash on migration numbers
         m.sleep 1 
         
         migration_template = 'add_default_site_id_to_users.rb'
        
          m.migration_template(
            migration_template, 'db/migrate', 
            :assigns => {
              :migration_name => "AddDefaultSiteIdTo#{class_name.gsub(/::/, '')}s"
            }, 
            :migration_file_name => "add_default_site_id_to_#{file_path.gsub(/\//, '_')}s"
          )
      end
      
    end
  end
end
