# These configuration options can be used to customise the behaviour of Magazine
Magazine.configure do |config|
  
  # Do you want to add comments to your blog?
   config.include_comments = true

  # The name of the controller method we'll call to return the current blogger.
  # Change this if you use something other than current_user.
  # Eg. current_admin_user (if using ActiveAdmin)
   config.current_blogger_method = :current_user

  # What method do we call on blogger to show who they are?
   config.blogger_display_name_method = :username

  # Which DateTime::FORMATS format do we use to display blog and comment publish time
   config.datetime_format = :short
  
  # Should the controllers cache the blog pages as HTML?
   config.cache_pages = false

  # No. of articles to show per page
  config.articles_per_page = 5

  # The name of the before filter we'll call to authenticate the current user.
   config.authentication_method = :authenticate_user!

  # The name of the before filter we'll call to check if current user is admin
   config.admin_authenticated_method = :redirect_unless_admin

  # If set to true, the comments form will POST and DELETE to the comments 
  # controller using AJAX calls.
   config.ajax_comments = true

  # If set to true, the create, edit, update and destroy actions
  # will be included. If set to false, you'll have to set these 
  # yourself elsewhere in the app.
   config.include_admin_actions = true

  # If set to true, links for new articles, editing articles and deleting comments
  # will be available. If set to false, you'll have to set these 
  # yourself in the templates.
   config.include_admin_links = true

  # The default format for parsing the blog content.
   config.default_parser = :markdown

  # If blog content contains code, this should be highlighted using
  # albino.
   config.highlight_code_syntax = true
  
  # RSS Feed title content
   config.rss_feed_title = "GayTravelBuddy.com Magazine"
  
  # RSS Feed description content
   config.rss_feed_description = "A Magazine from the people at GayTravelBuddy.com"
  
  # RSS Feed language
   config.rss_feed_language = "en"
  
  # When using redcarpet as content parser, pass these options as defaults.
  # @see here for more options: https://github.com/tanoku/redcarpet
  config.redcarpet_options = {
    :hard_wrap => true, 
    :filter_html => true, 
    :autolink => true, 
    :no_intraemphasis => true, 
    :fenced_code_blocks => true, 
    :gh_blockcode => true
  }
  
end
