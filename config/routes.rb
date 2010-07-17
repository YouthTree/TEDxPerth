TEDxPerth::Application.routes.draw do |map|
  
  namespace :admin do
    root :to => 'dashboard#index'
  end

end
