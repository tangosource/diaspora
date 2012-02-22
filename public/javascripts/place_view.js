Places = Backbone.View.extend({

  el: ('#publisher'),

  events: {
    "click #place_publisher": "addPlace"
  },

  initialize : function(place) {
    _.bindAll(this, 'findStringToReplace','searchTermFromValue', 'onSelect','addMentionToInput');

    if(place){
      visibleInput = $('#status_message_fake_text');
      this.onSelect(visibleInput,place,place.name);
    }

    $('#place_publisher').css('width','24px');
    this.setAutocomplete();
  },

  findStringToReplace: function(value, cursorIndex){
    var atLocation = value.lastIndexOf('=', cursorIndex);
    if(atLocation == -1){return [0,0];}
    var nextAt = cursorIndex;

    if(nextAt == -1){nextAt = value.length;}
    return [atLocation, nextAt];

  },

  searchTermFromValue: function(value, cursorIndex) {
    var stringLoc = this.findStringToReplace(value, cursorIndex);
    if(stringLoc[0] <= 2){
      stringLoc[0] = 0;
    }else{
      stringLoc[0] -= 2;
    }

    var relevantString = value.slice(stringLoc[0], stringLoc[1]).replace(/\s+$/,"");

    var matches = relevantString.match(/(^|\s)=(.+)/);
    if(matches){
      $.place = true;
      return matches[2];
    }else{
      return '';
    }
  },

  hiddenMentionFromPlace : function(placeData){
    return "={" + placeData.name + "; " + placeData.handle + "}";
  },

  hiddenMentionFromDestination : function(DestinationData){
    return "#" + DestinationData.name;
  },
  
  
  
  onSelect :  function(visibleInput, data, formatted) {

    if(data.add){
     data.name = data.name.slice(4,data.name.length);
     window.location = "/p/new?place[description_attributes][title]="+data.name
    }

    if (data.url.match(/destination/)){

      var visibleCursorIndex = visibleInput[0].selectionStart;
      var visibleLoc = this.addMentionToInput(visibleInput, visibleCursorIndex, formatted);
      $.Autocompleter.Selection(visibleInput[0], visibleLoc[1], visibleLoc[1]);

      var mentionString = this.hiddenMentionFromDestination(data);
      var mention = { visibleStart: visibleLoc[0],
        visibleEnd  : visibleLoc[1],
        mentionString : mentionString
      };

      Publisher.autocompletion.mentionList.push(mention);
      Publisher.oldInputContent = visibleInput.val();
      Publisher.hiddenInput().val(Publisher.autocompletion.mentionList.generateHiddenInput(visibleInput.val()));

    }else {

      var visibleCursorIndex = visibleInput[0].selectionStart;
      var visibleLoc = this.addMentionToInput(visibleInput, visibleCursorIndex, formatted);
      $.Autocompleter.Selection(visibleInput[0], visibleLoc[1], visibleLoc[1]);

      var mentionString = this.hiddenMentionFromPlace(data);
      var mention = { visibleStart: visibleLoc[0],
        visibleEnd  : visibleLoc[1],
        mentionString : mentionString
      };

      Publisher.autocompletion.mentionList.push(mention);
      Publisher.oldInputContent = visibleInput.val();
      Publisher.hiddenInput().val(Publisher.autocompletion.mentionList.generateHiddenInput(visibleInput.val()));

    }


  },

  addMentionToInput: function(input, cursorIndex, formatted){
    var inputContent = input.val();

    var stringLoc = this.findStringToReplace(inputContent, cursorIndex);

    var stringStart = inputContent.slice(0, stringLoc[0]);
    var stringEnd = inputContent.slice(stringLoc[1]);

    input.val(stringStart + formatted + stringEnd);
    var offset = formatted.length - (stringLoc[1] - stringLoc[0]);
    Publisher.autocompletion.mentionList.updateMentionLocations(stringStart.length, offset);
    return [stringStart.length, stringStart.length + formatted.length];
  },
  
  setAutocomplete: function(){

    self = this;

    $("#status_message_fake_text").autocomplete("/search.json", {
      minChars : 1,
      max : 5,
      cacheLength : 15,
      delay : 800,
      onSelect : self.onSelect,
      searchTermFromValue: self.searchTermFromValue,
      scroll : false,
      formatItem: function(row, i, max) {
        return "<img src='"+ row.avatar +"' class='avatar'/>" + row.name;
      },
      formatMatch: function(row, i, max) {
        return row.name;
      },
      formatResult: function(row) {
        return row.name;
      },
      disableRightAndLeft : true
    });
  },

  addPlace: function(){
    var input = $('#status_message_fake_text');
    var value = input.val();
    input.focus();
    var selection = input[0].selectionStart; 
    input[0].setSelectionRange(selection + 2,selection + 2);  
    input.val(value+'=');

    this.setAutocomplete();
    $.Autocompleter.default_value('Type a place name');
  }

});
