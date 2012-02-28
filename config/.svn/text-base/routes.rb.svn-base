ActionController::Routing::Routes.draw do |map|
  
  
  map.resources :grades, :member => {:getgradedata => :post, :getdisciplinas => :post, :getturmas => :post}
  
  map.resources :gradeshorarias 





  map.ofertasearches '/ofertasearches/search', :controller => 'ofertasearches', :action => "search"

  map.disciplinasearches '/disciplinasearch.js', :controller => 'disciplinasearches', :action => 'auto_complete'
  map.professorsearches  '/professorsearch.js',  :controller => 'professorsearches',  :action => 'auto_complete'
  map.departamentos      '/departamento.js',     :controller => 'departamentos',      :action => 'auto_complete'

  map.logout    '/logout', :controller => 'sessions', :action => 'destroy'
  map.login     '/login', :controller => 'sessions', :action => 'new'
  map.signup    '/cadastro', :controller => 'usuarios', :action => 'new'
  map.recuperar    '/recuperar', :controller => 'usuarios', :action => 'recuperar'
  map.reset     'reset/:reset_code', :controller => 'usuarios',     :action => 'reset'
  

  map.contato '/contato', :controller => 'contato', :action => 'index'
  
  map.resource :session

  map.resources :usuarios

  map.resources :posts
  
  map.resources :ofertasearches, :as => "ofertas", :path_names => {:new => "buscar"}
  
  map.resources :professorsearches, :as => "professor", :path_names => {:new => "buscar"}

  map.resources :disciplinasearches, :as => "disciplina", :path_names => {:new => "buscar"}
  
  map.resources :disciplinas, :path_names => {:show => "visualizar"}, :member => {:anexos => :post}
  
  map.resources :professores, :path_names => {:show => "visualizar"}
  
  map.resources :departamentos
  
  map.connect 'anexo', :controller => "anexo", :action => "index"
  
  
    
  map.root :controller => 'inicio'

=begin
  map.resources :fluxos

  map.resources :curriculos

  map.resources :cursos

  map.resources :habilitacoes

  map.resources :ofertas

  map.resources :horarios

  map.resources :reservas

  map.resources :professores

  map.resources :disciplinas

  map.resources :departamentos

  map.resources :campi
=end  

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
