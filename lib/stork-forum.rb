if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  dependency 'merb-slices', :immediate => true
  Merb::Plugins.add_rakefiles "stork-forum/merbtasks", "stork-forum/slicetasks", "stork-forum/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :stork-forum
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:stork_forum][:layout] ||= :stork_forum
  
  # All Slice code is expected to be namespaced inside a module
  module StorkForum
    
    # Slice metadata
    self.description = "StorkForum is a simple forum slice"
    self.version = "0.0.1"
    self.author = "Slawosz Slawinski and Maciej Egermeier"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(StorkForum)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :stork_forum_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)

	scope.resources :posts

      # example of a named route
      scope.match('/index(.:format)').to(:controller => 'main', :action => 'index').name(:index)
      # the slice is mounted at /stork-forum - note that it comes before default_routes
      scope.match('/').to(:controller => 'main', :action => 'index').name(:home)
      # enable slice-level default routes by default
      #scope.default_routes
    end
    
  end
  
  # Setup the slice layout for StorkForum
  #
  # Use StorkForum.push_path and StorkForum.push_app_path
  # to set paths to stork-forum-level and app-level paths. Example:
  #
  # StorkForum.push_path(:application, StorkForum.root)
  # StorkForum.push_app_path(:application, Merb.root / 'slices' / 'stork-forum')
  # ...
  #
  # Any component path that hasn't been set will default to StorkForum.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  StorkForum.setup_default_structure!
  
  # Add dependencies for other StorkForum classes below. Example:
  # dependency "stork-forum/other"
  
end
