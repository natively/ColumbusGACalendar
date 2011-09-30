jQuery(document).ready(function() {
  jQuery(".reset").click(function() {
    jQuery(".form_field").val("");
    return;
  });

  var dates = jQuery("#from, #to").datepicker({
    onSelect: function( selectedDate ) {
      var option = this.id == "from" ? "minDate" : "maxDate",
        instance = jQuery( this ).data( "datepicker" ),
        date = jQuery.datepicker.parseDate(
          instance.settings.dateFormat ||
          jQuery.datepicker._defaults.dateFormat,
          selectedDate, instance.settings );
      dates.not( this ).datepicker( "option", option, date );

      // jQuery.get(jQuery('#search_box').attr('action'), jQuery('#search_box').serialize(), null, 'script' );
    }
  });
});