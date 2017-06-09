
Set data in html
  .checkbox-label.pull-left data-id="123"

    $(".checkbox-label").click( function(event){
      var id=$(this).data('id')l
      $('#' + id).trigger('click');
    });
