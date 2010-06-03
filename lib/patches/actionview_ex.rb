# :stopdoc:
# Extending ActionView to support multiple sites templates with fallback to default templates
module ActionView
  class Base
    if Rails::version < '2.2' then
      
      alias_method :site_overload_old_render_file, :render_file
      # Overrides the default <tt>Base#render_file</tt> to allow site-specific views
      def render_file(template_path, use_full_path = false, local_assigns = {})
   
        search_path = []
  
        current_site = controller.current_site
        
        if !current_site.nil? && current_site != false && current_site != 'default' then
          search_path = [
          "#{RAILS_ROOT}/sites/#{current_site}/app/views", # for components
            ]
          @finder.prepend_view_path(search_path)
        end
   
        site_overload_old_render_file(template_path, use_full_path, local_assigns)
      end
    else
      alias_method :site_overload_old_view_paths, :view_paths
      
      def view_paths
        paths = site_overload_old_view_paths
   
        if controller and controller.current_site
          site_path = File.join(RAILS_ROOT, "sites", controller.current_site, "app/views")
          if File.exists?(site_path) and ! paths.include?(site_path)
            paths.unshift(site_path)
          end
        end
        paths
      end
    end
  end

  module Helpers
    # :startdoc:
    module AssetTagHelper
      
      # Computes the path to an asset in the public directory.
      # ==== Examples
      #   asset_path("images", "demo")                                         # => /images/demo
      #   asset_path("flash", "demo.swf")                                     # => /flash/demo.swf
      #   asset_path( "flash", "small/demo.swf")                               # => /flash/small/demo.swf
      
      def asset_path( asset, source)
        compute_public_path(source, asset)
      end
      
# :enddoc:
      alias_method :site_overload_compute_public_path, :compute_public_path
      
      def compute_public_path(source, dir, ext = nil, include_host = true)
        current_site = controller.current_site
  
        has_request = @controller.respond_to?(:request)
        
        # backup the source so we don't totally mangle it
        original_source = source
        original_dir = dir

        # strip of trailing ? on sources we're testing - don't worry, we use the original source when constructing the URI
        if source.include?('?') then
          source = source[0,source.index('?')]
        end
                
        # only check if we're using a overloaded site
        if !current_site.nil? && current_site != false && current_site != 'default' then
          
          # rewrite the dir to see what we have
          dir = "sites/#{current_site}/#{dir}"          
          source += ".#{ext}" if ext && File.extname(source).blank? || File.exist?(File.join(ASSETS_DIR, dir, "#{source}.#{ext}"))

          if source =~ %r{^[-a-z]+://}
            source
          else
            source = "#{dir}/#{source}" unless source[0] == ?/
            if has_request
              unless source =~ %r{^#{@controller.request.relative_url_root}/}
                source = "#{@controller.request.relative_url_root}#{source}"
              end
            end
          end
          # unless the file exists in the overloaded site, revert to the default, and log
          unless File.exist?( File.join(ASSETS_DIR, source))
            dir = original_dir
          end
          source = original_source
        end
        site_overload_compute_public_path(source, dir, ext, include_host)
      end

    end
  end
end