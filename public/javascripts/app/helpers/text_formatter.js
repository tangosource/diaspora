(function(){
  var textFormatter = function textFormatter(model) {
    var text = model.get("text");
    var skip = model.get("skip_formatting");

    if(skip)
      return text;
    else{
      mentions = model.get("mentioned_people");
      places = model.get("mentioned_places");

      if(places){
        if(typeof places[0] != 'undefined'){
          mentions.push(places[0]);
        }
      }

      return textFormatter.mentionify(
        textFormatter.hashtagify(
          textFormatter.markdownify(text)
          ), mentions
        )
    }
  };

  textFormatter.markdownify = function markdownify(text){
    var converter = Markdown.getSanitizingConverter();
    return converter.makeHtml(text)
  };

  textFormatter.hashtagify = function hashtagify(text){
    var utf8WordCharcters =/(\s|^|>)#([\u0080-\uFFFF|\w|-]+|&lt;3)/g
    return text.replace(utf8WordCharcters, function(hashtag, preceeder, tagText) {
      return preceeder + "<a href='/tags/" + tagText + "' class='tag'>#" + tagText + "</a>"
    })
  };

  textFormatter.mentionify = function mentionify(text, mentions) {
    var mentionRegex = /[@|=]\{([^;]+); ([^\}]+)\}/g

    return text.replace(mentionRegex, function(mentionText, fullName, diasporaId) {

      var person = _.find(mentions, function(person){
        return person.diaspora_id == diasporaId
      });

      var place = _.find(mentions, function(place){
        return place.handle == diasporaId
      });
     
      if(place)
      return "<a href='/p/" + place.id + "' class='mention'>" + fullName + "</a>"

      return person ? "<a href='/people/" + person.guid + "' class='mention'>" + fullName + "</a>" : fullName;
    })

  }

  app.helpers.textFormatter = textFormatter;
})();

