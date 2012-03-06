$(document).ready( function(){
  $('#card_number').val(5224980108320195);
var subscription;
jQuery(function() {
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  return subscription.setupForm();
});
subscription = {
  setupForm: function() {
      $('input[type=submit]').on('click', function(e){

        $(this).attr('disabled', true);
        //Freeze the submit event in order to wait for a response from Sprite
        e.preventDefault();

        return subscription.processCard();
      });
  },
  processCard: function() {
    var card;
    card = {
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      expMonth: $('#card_month').val(),
      expYear: $('#card_year').val()
    };
    return Stripe.createToken(card, subscription.handleStripeResponse);
  },
  handleStripeResponse: function(status, response) {
    if (status === 200) {
      alert(response.id);

      // Execute the submit
      $('#new_subscription').submit();

    } else {
      alert(response.error.message);
      $('#stripe_error').text(response.error.message);
      $('input[type=submit]').attr('disabled', false);
    }
  }
};
});
