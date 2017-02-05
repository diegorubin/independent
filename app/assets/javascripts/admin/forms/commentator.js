/* list of commentators */
$('.commentator-toggle').change(function(){
  var commentator_id = $(this).attr('rel');
  var active = $(this).prop('checked');

  var client = new RestClient('/admin/commentators/' + commentator_id);
  client.success = function(){
    $.bootstrapGrowl(polyglot.t("messages.save.success"), {type: 'success'});
  };

  client.call('patch', {'commentator[active]': active});

});

