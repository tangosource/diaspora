var privacyForm = $('#profile_edit');

$(function(){
  $('#profile_public').change(function(){
    $.ajax({
      url: privacyForm.attr('action'),
      type: 'post',
      data: privacyForm.serialize(),
      dataType: 'json',
      success: function(data){
        Diaspora.page.flashMessages.render({success: data.success, notice: data.msg});
      }
    });
  });
});
