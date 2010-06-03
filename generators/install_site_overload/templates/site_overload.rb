# provides additional boilerplate methods useful for site overloading

# Assumes:
# you have a user model that includes a default_site that references
# a site model that lists your main sites including setting a system default.

module SiteOverload
  ApplicationController.class_eval do
    site :determine_site
  end
  private
  # check the domain requested exists. if not, send the user to their default site (if known) or the system default site
  # if the user has a default site set (either directly, or through a study requirement), then redirect them to that site
    def check_domain_exists

      system_default_site = Site.find(:first, :conditions => {:is_default => true })
      
      @current_site = Site.find_by_fully_qualified_domain( request.host )
      
      # check:
      # * this site exists
      # and either:
      # * this site is live
      # * or user is admin
      # if not, redirect to the system default
      unless @current_site and @current_site.is_live?
        redirect_to url_for( :host => system_default_site.fully_qualified_domain, :port => system_default_site.port || request.port)
      end
    end
    
    # check if this user is set a default site. if they are, and this isn't that site, redirect them there
    def check_user_domain
      if @current_user and 
        @current_user.default_site and 
        @current_user.default_site != @current_site
        redirect_to url_for( :host => @current_user.default_site.fully_qualified_domain, :port => @current_user.default_site.port || request.port )
      end
    end    
   
  # To determine the site displayed to the user, we check the requests host.
    def determine_site
      @current_site.nil? ? nil : @current_site.name
    end
end