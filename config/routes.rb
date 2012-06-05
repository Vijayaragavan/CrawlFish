CrawlFish::Application.routes.draw do

  get "merchants_financials/index"

  get "merchants_financials/fixed"

  get "merchants_financials/variable"

  get "merchants_financials/purchase"

  #get "merchants_datafeed/upload"

  match '/impressions/:type/:unique_ids_array' => 'logger#impressions'

  match '/clicks/:type/:unique_id' => 'logger#clicks'

  match '/merchants_financials/variable_paginate/page=:page/sub_category_id=:sub_category_id' => 'merchants_financials#variable_paginate'

  match '/merchants_financials/variable_categorize/sub_category_id=:sub_category_id' => 'merchants_financials#variable_paginate'

   match '/merchants_financials/fixed_paginate/page=:page/sub_category_id=:sub_category_id' => 'merchants_financials#fixed_paginate'

  match '/merchants_financials/fixed_categorize/sub_category_id=:sub_category_id' => 'merchants_financials#fixed_paginate'

  match '/merchants_financials/purchase_paginate/page=:page/sub_category_id=:sub_category_id' => 'merchants_financials#purchase_paginate'

  match '/merchants_financials/purchase_categorize/sub_category_id=:sub_category_id' => 'merchants_financials#purchase_paginate'

   match '/merchants_financials/i_c_paginate/page=:page/sub_category_id=:sub_category_id' => 'merchants_financials#i_c_paginate'

  match '/merchants_financials/i_c_categorize/sub_category_id=:sub_category_id' => 'merchants_financials#i_c_paginate'

  match "merchants_products/index/:query" => "merchants_products#index"

  match "merchants_products/index" => "merchants_products#index"

  match "merchants_products/search/:query" => "merchants_products#search"

  match 'merchants_dashboard/range/:from_date/:to_date/:vendor_id/:sub_category_id' => 'merchants_dashboard#range'

  match '/merchants_dashboard/categorize/:sub_category_id/:vendor_id' => 'merchants_dashboard#categorize'

  get "footer/about_us",:as => "about_us"

  get "footer/faq", :as => "faq"

  get "footer/merchant_login", :as => "merchant_login"

  get "footer/privacy_statement" , :as => "privacy_statement"

  get "footer/speak_to_us", :as => "speak_to_us"

  match 'footer/whatwedo' => 'footer#whatwedo'

  match 'footer/whatwebelieve' => 'footer#whatwebelieve'

  match 'footer/overview' => 'footer#overview'

  match 'footer/c101' => 'footer#c101'

  match 'footer/cfaq' => 'footer#cfaq'

 match '/autocomplete/show' => 'autocomplete#show'

 match "merchant_sign_up" => "merchants_lists#new", :as => "merchant_sign_up_form"

 match "log_out" => "merchants#destroy", :as => "log_out"

 match "log_in" => "merchants_sessions#new", :as => "log_in"

 match "merchants_home" => "merchants#home", :as => "merchants_home"

  get '/merchants_lists/show_areas/:id' => 'merchants_lists#show_areas'

 match '/show_sign_up/:type_id/:city_id/:area_id' => 'merchants_lists#show_sign_up'

 match '/show_city_area_option/:type_id' => 'merchants_lists#show_city_area_option'

 match '/merchants_products/new' => 'merchants_products#new'

 match '/merchants_products/create' => 'merchants_products#create'

 resources :merchants_sessions

 resources :ajax

 match 'ajax/index' => 'ajax#index'

 match 'search/index' => 'Search#index'

 match 'index' => 'Search#index'

 match '/shared/index' => 'search#index'

 match 'search/specific' => 'Search#specific'

 match 'search/startSpecificSearch' => 'Search#startSpecificSearch'

 match '/converse.js' => 'Converse#index'

  # The priority is based upon order of creation:match 'products/:id' => 'catalog#view'
  # first created -> highest priority.
 match 'search/binding/:binding_id' => 'search#binding'

 match 'filter/genre/:genre_id/:sub_category_id' => 'filter#genre'

 get '/bnm/show_areas/:id' => 'bnm#show_areas'

 get'/bnm/show_local_shops/area_id=:area_id/product_id=:product_id/sub_category_id=:sub_category_id' => 'bnm#show_local_shops'

 match 'category/switch/:sub_category_id' => 'category#index'

 match 'specific/:specific_product_id/:specific_sub_category_id' => 'specific#specific_search' , :as => :specific

  match 'specific/include_exclude_view_all_local/product_id=:product_id/sub_category_id=:sub_category_id/include=:include/type=:type/area_id=:area_id/page=:page' => 'specific#include_exclude_view_all_local'

   match 'local/show_gmap/:vendor_name/:branch_name' => 'local#show_gmap'

    match 'local/send_sms/:type/:phone_number/:vendor_id/:product_id/:sub_category_id' => 'local#send_sms'


   match '/local/change_vendor_details/:vendor_id' => 'local#change_vendor_details'

 match ':controller(/:action(/:id))'


 unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end


  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action


  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'main#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

