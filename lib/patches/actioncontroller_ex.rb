# Extends ActionController to support multiple sites
ActionController::Base.class_eval do
 
  attr_accessor :current_site
     
  # Use this in your controller just like the <tt>layout</tt> macro.
  # Example:
  #
  # site 'site_name'
  #
  # -or-
  #
  # site :get_site
  #
  # def get_site
  # 'site_name'
  # end
  def self.site(site_name, conditions = {})
    # TODO: Allow conditions... (?)
    write_inheritable_attribute "site", site_name
  end
   
  # Retrieves the current set site
  def current_site(passed_site=nil)
    site = passed_site || self.class.read_inheritable_attribute("site")
       
    @active_site = case site
      when Symbol then send(site)
      when Proc then site.call(self)
      when String then site
    end
  end

end