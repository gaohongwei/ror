// 1. Pass  data from rails to javascript
  // slim, cannot pass array
  var js_array = #{raw rails__array};
  var sheet_columns = "#{rails_var}"; 
  // erb
  var js_array = <%= rails__array %>
  var js_var = <%= rails_var %>
// 2. Set data in html
  // erb
  <div class="user-details" data-user-id="<%= @user.id %>">
  </div>

  //slim
  .checkbox-label.pull-left data-id="123"

    $(".checkbox-label").click( function(event){
      var id=$(this).data('id')l
      $('#' + id).trigger('click');
    });
