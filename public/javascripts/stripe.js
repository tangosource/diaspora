var subscription;
jQuery(function() {
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  return subscription.setupForm();
});
subscription = {
  setupForm: function() {
    return $('#new_subscription').submit(function() {
      $('input[type=submit]').attr('disabled', true);
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
      return alert(response.id);
    } else {
      return alert(response.error.message);
    }
  }
};
