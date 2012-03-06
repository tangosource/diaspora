$(document).ready( function(){
var subscription;
jQuery(function() {
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  return subscription.setupForm();
});
subscription = {
  setupForm: function() {
      $('input[type=submit]').on('click', function(e){
        $(this).attr('disabled', true);
        subscription.processCard();
        false;
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
      $('#subscription_stripe_card_token').val(response.id);
      $('#new_subscription').submit();
    } else {
      $('#stripe_error').text(response.error.message);
      $('input[type=submit]').attr('disabled', false);
    }
  }
};
});
