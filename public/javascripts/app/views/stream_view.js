app.views.Stream = Backbone.View.extend({
  events: {
    "click #paginate": "render"
  },

  initialize: function(options) {
    this.stream = app.stream || new app.models.Stream()
    this.collection = this.stream.posts
    this.publisher = new app.views.Publisher({collection : this.collection});

    this.stream.bind("fetched", this.streamFetched, this)
    this.stream.bind("allPostsLoaded", this.allPostsLoaded, this)

    this.collection.bind("add", this.addPost, this);
    this.setupInfiniteScroll()
    this.setupLightbox()
  },

  addPost : function(post) {
    var postView = new app.views.Post({ model: post });

    $(this.el)[
      (this.collection.at(0).id == post.id)
        ? "prepend"
        : "append"
    ](postView.render().el);

    return this;
  },

  allPostsLoaded : function() {
    $(window).unbind("scroll");
  },

  streamFetched : function() {
    this.removeLoader();
  },

  render : function(evt) {
    if(evt) { evt.preventDefault(); }

    // fetch more posts from the stream model
    if(this.stream.fetch()) {
      this.appendLoader()
    };

    return this;
  },

  appendLoader: function(){
    $("#paginate").html($("<img>", {
      src : "/images/static-loader.png",
      "class" : "loader"
    }));
  },

  removeLoader: function() {
    $("#paginate").html("");
  },

  setupLightbox : function(){
    this.lightbox = Diaspora.BaseWidget.instantiate("Lightbox");
    $(this.el).delegate("a.stream-photo-link", "click", this.lightbox.lightboxImageClicked);
  },

  setupInfiniteScroll : function() {
    var throttledScroll = _.throttle($.proxy(this.infScroll, this), 200);
    $(window).scroll(throttledScroll);
  },

  infScroll : function() {
    var $window = $(window);
    var distFromTop = $window.height() + $window.scrollTop();
    var distFromBottom = $(document).height() - distFromTop;
    var bufferPx = 500;

    if(distFromBottom < bufferPx) {
      this.render();
    }

    return this;
  },
});
