Publisher.places = {}
Publisher.places.view = Backbone.View.extend({

  el: ('#publisher'),

  events : {
    "keydown #status_message_fake_text": "keyDownHandler"
  },

  initialize : function() {
    _.bindAll(this, 'keyDownHandler');
    this.setAutocomplete(".selected_contacts_link");
  },

  keyDownHandler: function(){
    var input = $('#status_message_fake_text');
    var selectionStart = input[0].selectionStart;
    var selectionEnd = input[0].selectionEnd;
    var isDeletion = (event.keyCode == KEYCODES.DEL && selectionStart < input.val().length) || (event.keyCode == KEYCODES.BACKSPACE && (selectionStart > 0 || selectionStart != selectionEnd));
    var isInsertion = (KEYCODES.isInsertion(event.keyCode) && event.keyCode != KEYCODES.RETURN );

    if(isDeletion){
      console.log(input.val());
    }else if(isInsertion){
      console.log(input.val());
    }
    
  },

  setAutocomplete: function(Ajax){
      $.getJSON($("#publisher "+Ajax).attr("href"), undefined ,
        function(data){
          $("#status_message_fake_text").autocomplete(data, {
            minChars : 1,
            max : 5,
            onSelect : Publisher.autocompletion.onSelect,
            searchTermFromValue: Publisher.autocompletion.searchTermFromValue,
            scroll : false,
            formatItem: function(row, i, max) {
              return "<img src='"+ row.avatar +"' class='avatar'/>" + row.name;
            },
            asa: (function(){console.log()})(),
            formatMatch: function(row, i, max) {
              return row.name;
            },
            formatResult: function(row) {
              return row.name;
            },
            disableRightAndLeft : true
          });
        }
    );
  }

});

$(document).ready(function() {
  var places = new Publisher.places.view();
});
