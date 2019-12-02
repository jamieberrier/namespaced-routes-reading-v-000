Rails.application.routes.draw do
  resources :authors, only: %i[show index] do
    resources :posts, only: %i[show index new edit]
  end

  resources :posts, only: %i[index show new create edit update]
=begin
  # We're telling scope that we want to use /admin as a URL prefix, and we're also letting Rails know that all of the included routes will be handled by controllers in the admin module.
  scope '/admin', module: 'admin' do
    resources :stats, only: [:index]
  end
=end
  # The namespace method makes the assumption that the path prefix and module name match, saving us some typing.
  namespace :admin do
    resources :stats, only: [:index]
  end
  # There is one important difference between scope '/admin', module: 'admin' and namespace :admin, and it's in the URL helpers. Remember above that using scope gave us a stats_path helper. But now that we are using namespace, run rake routes again. You'll see that the helper is now prefixed with admin_, so stats_path becomes admin_stats_path. If you switch from scope to namespace, take care to update any URL helpers you have in use!
  root 'posts#index'
end
