$(document).ready(function() {
  $(".cal_from").datepicker({
    onSelect: function() {
      $("#search_box").submit();
    },
    altField: "#from",
    prevText: "&larr; Prev",
    nextText: "Next &rarr;"
  });

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

  $('.event_name a').bind('click', function(){
    $(this).parent().next('.event_details').toggle();
    return false;
  });
});