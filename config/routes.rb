#   Copyright (c) 2010-2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

Diaspora::Application.routes.draw do

  get "search" => "search#index", :as => "search"

	# Keep these above the posts resources block
  match "m/page/:page" => "magazine/articles#index"
  match "m/tagged/:tag" => 'magazine/articles#tagged', :as => :tagged_articles
  get "m" => "magazine/articles#index", :as => "magazine"

	scope 'm', :module => :magazine do
    #Added next line because articles#show is overriding magazine's gem ones
    match "a/approve/:id" => 'articles#approve', :as => :approve_articles
    match "a/toggle_feature/:id" => 'articles#toggle_feature', :as => :toggle_feature_articles
    match "a/toggle_publish/:id" => 'articles#toggle_publish', :as => :toggle_publish_articles
	  resources :a, :controller => "articles", :as => "magazine_articles" do
      #Added next lines because articles#show is overriding magazine's gem ones
      collection do
        get :review
      end
	    resources :comments, :controller => "comments", :as => "magazine_comments", :only => [:create, :destroy]
	  end
	end
	
  get "d/search" => "destinations#search", :as => "search_destinations"
  resources :d, :controller=> 'destinations', :as => 'destinations' do 
    get 'photos'
  end

  get "places/search" => "places#search", :as => "search_places"
  resources :p, :controller => 'places', :as => 'places' do
    resources :photos
  end

  get 'p/get_place/:id' => 'places#get_place'

  # Posting and Reading

  resources :reshares

  resources :status_messages, :only => [:new, :create]

  resources :posts, :only => [:show, :destroy] do
    resources :likes, :only => [:create, :destroy, :index]
    resources :comments, :only => [:new, :create, :destroy, :index]
  end
  get 'p/:id' => 'posts#show', :as => 'short_post'
  # roll up likes into a nested resource above
  resources :comments, :only => [:create, :destroy] do
    resources :likes, :only => [:create, :destroy, :index]
  end

  # Streams
  get "public" => "streams#public", :as => "public_stream"
  get "public" => "streams#public", :as => "public_stream"
  get "stream" => "streams#multi", :as => "multi_stream"
  get "followed_tags" => "streams#followed_tags", :as => "followed_tags_stream"
  get "stream" => "streams#multi", :as => "multi_stream"
  get "followed_tags" => "streams#followed_tags", :as => "followed_tags_stream"
  get "mentions" => "streams#mentioned", :as => "mentioned_stream"
  get "liked" => "streams#liked", :as => "liked_stream"
  get "commented" => "streams#commented", :as => "commented_stream"
  get "aspects" => "streams#aspects", :as => "aspects_stream"

  resources :aspects do
    put :toggle_contact_visibility
  end

  get 'bookmarklet' => 'status_messages#bookmarklet'

  resources :photos, :except => [:index] do
    put :make_profile_photo
  end

  # ActivityStreams routes
  scope "/activity_streams", :module => "activity_streams", :as => "activity_streams" do
    resources :photos, :controller => "photos", :only => [:create]
  end

  resources :conversations do
    resources :messages, :only => [:create, :show]
    delete 'visibility' => 'conversation_visibilities#destroy'
  end

  get 'notifications/read_all' => 'notifications#read_all'
  resources :notifications, :only => [:index, :update] do
  end

  resources :tags, :only => [:index]
  scope "tags/:name" do
    post   "tag_followings" => "tag_followings#create", :as => 'tag_tag_followings'
    delete "tag_followings" => "tag_followings#destroy", :as => 'tag_tag_followings'
  end

  post   "multiple_tag_followings" => "tag_followings#create_multiple", :as => 'multiple_tag_followings'
  resources "tag_followings", :only => [:create]

  get 'tags/:name' => 'tags#show', :as => 'tag'

  resources :apps, :only => [:show]

  #Cubbies info page

  resource :token, :only => :show

  # Users and people

  resource :user, :only => [:edit, :update, :destroy], :shallow => true do
    get :getting_started_completed
    get :export
    get :export_photos
  end

  controller :users do
    get 'public/:username'          => :public,           :as => 'users_public'
    match 'getting_started'         => :getting_started,  :as => 'getting_started'
    match 'privacy'                 => :privacy_settings, :as => 'privacy_settings'
    get 'getting_started_completed' => :getting_started_completed
    get 'confirm_email/:token'      => :confirm_email,    :as => 'confirm_email'
  end

  # This is a hack to overide a route created by devise.
  # I couldn't find anything in devise to skip that route, see Bug #961
  match 'users/edit' => redirect('/user/edit')

  devise_for :users, :controllers => {:registrations => "registrations",
                                      :password      => "devise/passwords",
                                      :sessions      => "sessions",
                                      :invitations   => "invitations"} do
    get 'invitations/resend/:id' => 'invitations#resend', :as => 'invitation_resend'
    get 'invitations/email' => 'invitations#email', :as => 'invite_email'
  end

  get 'login' => redirect('/users/sign_in')

  scope 'admins', :controller => :admins do
    match :user_search
    get   :admin_inviter
    get   :weekly_user_stats
    get   :correlations
    get   :users_list
    match 'toggle_admin/:id' => 'admins#toggle_admin', :as => 'toggle_admin', :via => :get
    get   :stats, :as    => 'pod_stats'
  end

  resource :profile, :only => [:edit, :update] do
    put :update_privacy, :on => :collection
  end

  resources :contacts,           :except => [:update, :create] do
    get :sharing, :on => :collection
  end
  resources :aspect_memberships, :only  => [:destroy, :create]
  resources :share_visibilities,  :only => [:update]
  resources :blocks, :only => [:create, :destroy]

  get 'community_spotlight' => "contacts#spotlight", :as => 'community_spotlight'

  resources :people, :except => [:edit, :update] do
    resources :status_messages
    resources :photos
    get  :contacts
    get "aspect_membership_button" => :aspect_membership_dropdown, :as => "aspect_membership_button"
    collection do
      post 'by_handle' => :retrieve_remote, :as => 'person_by_handle'
      get :tag_index
    end
  end
  get '/u/:username' => 'people#show', :as => 'user_profile'
  get '/u/:username/profile_photo' => 'users#user_photo'
  # Federation

  controller :publics do
    get 'webfinger'             => :webfinger
    get 'hcard/users/:guid'     => :hcard
    get 'privacy_policy'        => :privacy
		get 'contact'								=> :contact
    get 'statements'            => :statements
    get '.well-known/host-meta' => :host_meta
    post 'receive/users/:guid'  => :receive
    post 'receive/public'       => :receive_public
    get 'hub'                   => :hub
  end

  get '/pages/:action' => 'pages'

  # External

  resources :authorizations, :only => [:index, :destroy]
  scope "/oauth", :controller => :authorizations, :as => "oauth" do
    get "authorize" => :new
    post "authorize" => :create
    post :token
  end

  resources :services, :only => [:index, :destroy]
  controller :services do
    scope "/auth", :as => "auth" do
      match ':provider/callback' => :create
      match :failure
    end
    scope 'services' do
      match 'inviter/:provider' => :inviter, :as => 'service_inviter'
      match 'finder/:provider'  => :finder,  :as => 'friend_finder'
    end
  end

  scope 'api/v0', :controller => :apis do
    get :me
  end

  namespace :api do
    namespace :v0 do
      get "/users/:username" => 'users#show', :as => 'user'
      get "/tags/:name" => 'tags#show', :as => 'tag'
    end
  end


  # Mobile site

  get 'mobile/toggle', :to => 'home#toggle_mobile', :as => 'toggle_mobile'

  #Protocol Url
  get 'protocol' => redirect("https://github.com/diaspora/diaspora/wiki/Diaspora%27s-federation-protocol")

  # Resque web
  if AppConfig[:mount_resque_web]
    mount Resque::Server.new, :at => '/resque-jobs', :as => "resque_web"
  end

  # Logout Page (go mobile)
  get 'logged_out' => 'users#logged_out', :as => 'logged_out'

  # Startpage
  root :to => 'home#show'

  # privacy


end
