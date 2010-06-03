if Rails::version >= '2.2' then
  module SiteOverload
  
    module RoutingExtensions
      def site_overloading
        @set.with_options :controller => 'site' do |site|
          site.add_named_route 'site_images',
            '/sites/:site/public/images/*filename', :action => 'images'
   
          site.add_named_route 'site_stylesheets',
            '/sites/:site/public/stylesheets/*filename', :action => 'stylesheets'
   
          site.add_named_route 'site_javascript',
            '/sites/:site/public/javascript/*filename', :action => 'javascript'
   
          site.add_route '/sites/*whatever', :action => 'error'
        end
      end
    end
  end
   
  ActionController::Routing::RouteSet::Mapper.send :include, SiteOverload::RoutingExtensions
end