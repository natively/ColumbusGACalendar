(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

$(document).ready(function() {  
  
  // grrrr....
  var params_date = $('#from').val();
  $(".cal_from").datepicker({
    onSelect: function() {
      $("#search_box").submit();
    },
    altField: "#from",
    prevText: "&larr; Prev",
    nextText: "Next &rarr;"
  });
  $('#from').val(params_date);

  $(".reset").click(function() {
    $(".form_field").val("");
    return;
  });

  var dates = $("#from, #to").datepicker({
    onSelect: function( selectedDate ) {
      var option = this.id == "from" ? "minDate" : "maxDate",
        instance = $( this ).data( "datepicker" ),
        date = $.datepicker.parseDate(
          instance.settings.dateFormat ||
          $.datepicker._defaults.dateFormat,
          selectedDate, instance.settings );
      dates.not( this ).datepicker( "option", option, date );
    },
    prevText: "&larr; Prev",
    nextText: "Next &rarr;"
  });

});