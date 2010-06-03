namespace :sites do
  namespace :cache do
    desc "Creates the cached (public) sites folders"
    task :create do
      for site in Dir.glob("#{RAILS_ROOT}/sites/*")
        site_name = site.split( File::Separator )[-1]
        puts "Creating #{RAILS_ROOT}/public/sites/#{site_name}"
        
        FileUtils.mkdir_p "#{RAILS_ROOT}/public/sites/#{site_name}"
            
#        FileUtils.cp_r "#{site}/public/images", "#{RAILS_ROOT}/public/sites/#{site_name}/images", :verbose => true
#        FileUtils.cp_r "#{site}/public/stylesheets", "#{RAILS_ROOT}/public/sites/#{site_name}/stylesheets", :verbose => true
#        FileUtils.cp_r "#{site}/public/javascripts", "#{RAILS_ROOT}/public/sites/#{site_name}/javascripts", :verbose => true
        # instead of trying to do each public subdir seperately, do them all in one go
        FileUtils.cp_r "#{site}/public/.", "#{RAILS_ROOT}/public/sites/#{site_name}", :verbose => true
      end
    end
     
    desc "Removes the cached (public) site folders"
    task :remove do
      puts "Removing #{RAILS_ROOT}/public/sites"
      FileUtils.rm_r "#{RAILS_ROOT}/public/sites", :force => true
    end
     
    desc "Updates the cached (public) site folders"
    task :update => [:remove, :create]
  end
end