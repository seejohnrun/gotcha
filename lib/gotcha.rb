module Gotcha

  require File.dirname(__FILE__) + '/gotcha/base'
  autoload :FormHelpers, File.dirname(__FILE__) + '/gotcha/form_helpers'
  autoload :ControllerHelpers, File.dirname(__FILE__) + '/gotcha/controller_helpers'

  # Remove all gotcha types
  def self.unregister_all_types
    @gotcha_types = []
  end

  # Register a Gotcha type
  def self.register_type(type)
    @gotcha_types ||= []
    @gotcha_types << type
  end

  # Get a random Gotcha from the registered types
  def self.random
    if !@gotcha_types.nil? && type = @gotcha_types.sample
      type.new 
    end
  end

  def self.gotcha_types
    @gotcha_types ||= []
  end

end

ActionView::Base.send(:include, Gotcha::FormHelpers)
ActionController::Base.send(:include, Gotcha::ControllerHelpers)

Dir.glob(File.dirname(__FILE__) + '/../gotchas/*_gotcha.rb').each { |f| require f }
