# Extend the Base ActionMailer to support sites
ActionMailer::Base.class_eval do
  
  alias_method :__render, :render
  alias_method :__initialize, :initialize
 
  @current_site = nil
 
  attr_reader :current_site
   
  def initialize(method_name=nil, *parameters)
    if parameters[-1].is_a? Hash and (parameters[-1].include? :site)
      @current_site = parameters[-1][:site]
      parameters[-1].delete :site
      parameters[-1][:current_site] = @current_site
    end
    create!(method_name, *parameters) if method_name
  end

  def render(opts)
    body = opts.delete(:body)
    if opts[:file] && (opts[:file] !~ /\// && !opts[:file].respond_to?(:render))
      opts[:file] = "#{mailer_name}/#{opts[:file]}"
    end

    begin
      old_template, @template = @template, initialize_template_class(body)
      layout = respond_to?(:pick_layout, true) ? pick_layout(opts) : false
      @template.render(opts.merge(:layout => layout))
    ensure
      @template = old_template
    end
  end
  
end