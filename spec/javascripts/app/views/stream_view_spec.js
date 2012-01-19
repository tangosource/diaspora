describe("app.views.Stream", function(){
  beforeEach(function(){
    loginAs({name: "alice", avatar : {small : "http://avatar.com/photo.jpg"}});

    this.posts = $.parseJSON(spec.readFixture("multi_stream_json"))["posts"];

    app.stream = new app.models.Stream()
    app.stream.add(this.posts);

    this.collection = app.stream.posts
    this.view = new app.views.Stream({collection : this.collection});

    app.stream.bind("fetched", this.collectionFetched, this) //untested

    // do this manually because we've moved loadMore into render??
    this.view.render();
    _.each(this.view.collection.models, function(post){ this.view.addPost(post); }, this);
  })

  describe("initialize", function(){
    it("binds an infinite scroll listener", function(){
      spyOn($.fn, "scroll");

      new app.views.Stream();
      expect($.fn.scroll).toHaveBeenCalled()
    })
  })

  describe("#render", function(){
    beforeEach(function(){
      this.statusMessage = this.collection.models[0];
      this.reshare = this.collection.models[1];
      this.statusElement = $(this.view.$("#" + this.statusMessage.get("guid")));
      this.reshareElement = $(this.view.$("#" + this.reshare.get("guid")));
    })

    context("when rendering a Status Mesasage", function(){
      it("shows the status message in the content area", function(){
        expect(this.statusElement.find(".post-content p").text()).toContain("you're gonna love this") //markdown'ed
      })
    })
  })

  describe("infScroll", function(){
    // NOTE: inf scroll happens at 500px

    it("calls render when the user is at the bottom of the page", function(){
      spyOn($.fn, "height").andReturn(0)
      spyOn($.fn, "scrollTop").andReturn(100)
      spyOn(this.view, "render")

      this.view.infScroll();
      expect(this.view.render).toHaveBeenCalled();
    })
  })

  describe("streamFetched", function() {
    it("triggers on stream.fetched", function(){
      spyOn(this.view, "streamFetched")
      this.view.stream.trigger("fetched")
      expect(this.view.streamFetched()).toHaveBeenCalled()
    })

    it("calls removeLoader()", function() {
      spyOn(this.view, "removeLoader")
      this.view.streamFetched()
      expect(this.view.removeLoader()).toHaveBeenCalled()
    })
  })

  describe("allPostsLoaded", function(){
    it("triggers on stream.allPostsLoaded", function(){
      spyOn(this.view, "allPostsLoaded")
      this.view.stream.trigger("allPostsLoaded")
      expect(this.views.allPostsLoaded()).toHaveBeenCalled()
    })

    it("unbinds scroll", function() {
      spyOn($.fn, "unbind")

      this.view.allPostsLoaded()
      expect($.fn.unbind).toHaveBeenCalled()
    })
  })
})
