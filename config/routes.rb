require 'resque/server'

Droolitapi::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"

  devise_for :users, :controllers => {
    :registrations => "registrations",
    :confirmations => "confirmations",
    :sessions => "sessions",
    :passwords => "passwords"
  },
  :class_name => 'User' do
    post "register_with_oauth", :to => "registrations#create_with_oauth"
    get "users/activate", :to => "registrations#activate"
    #post "reset_password_token", :to => "passwords#send_reset_password_token"
  end

  put 'users/change_password' => 'users#change_password', :as => 'user_change_password'
  get 'users' => 'users#index'
  get 'users/is_admin' => 'users#is_admin', :as => 'user_is_admin'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
