ActionController::Routing::Routes.draw do |map|
	map.root :controller => 'users', :action => 'index'

  map.resources :clients, :shallow => true do |client|
	  client.resources :invoices, :shallow => true, :name_prefix => nil do |invoice|
	    invoice.resources :payments, :shallow => true, :name_prefix => nil
	  end
    client.resources :line_items,
      :shallow => true,
      :except => [:index, :show],
      :member => [:set_line_item_rate, :set_line_item_notes],
      :collection => [:merge],
      :name_prefix => nil
	end
	
	map.clock_in '/clients/:client_id/clock_in', :controller => 'line_items', :action => 'clock_in'
	map.clock_out '/clients/:client_id/line_item/:id/clock_out', :controller => 'line_items', :action => 'clock_out'
  
  map.resources :users
  map.resource :session
	map.signup '/signup', :controller => 'users', :action => 'new'
	map.login '/login', :controller => 'sessions', :action => 'new'
	map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
