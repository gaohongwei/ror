html:
  <tr><td><div class='show_or_hide'>

  $('tr td').hover(show_hide('show'),show_hide('hide'));
  function show_hide(act){
    return function(){
      var dom=$(this).find('.show_or_hide')
      if ('show' == act){
        dom.removeClass('hide_me');
      } else {
        dom.addClass('hide_me');
      }
    }
  }
