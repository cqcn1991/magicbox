Rails.application.routes.draw do
  resources :notices
  resources :posts

  resources :videos
  resources :shops
  resources :items

  scope '/admin' do
    get 'videos' => 'videos#admin', as: :admin_videos
    get 'posts' => 'posts#admin', as: :admin_posts
    get 'items' => 'items#admin', as: :admin_items
    get 'shops' => 'shops#admin', as: :admin_shops
    get 'notices' => 'notices#admin', as: :admin_notices
  end

  root 'static_pages#home'

  get 'discussion' => 'static_pages#discussion'
  get 'selected' => 'static_pages#selected'
  get 'pop' => 'static_pages#popular'
  get 'mobile' => 'static_pages#mobile'

  get 'admin' => 'static_pages#admin'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
