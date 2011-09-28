jQuery(document).ready(function() {
  var dates = jQuery("#from, #to").datepicker({
    beforeShow: function (textbox, instance) {
      instance.dpDiv.css({
        marginTop: (textbox.offsetHeight) + 'px',
        marginLeft: textbox.offsetWidth + 'px'
      });
    },
    onSelect: function( selectedDate ) {
        var option = this.id == "from" ? "minDate" : "maxDate",
          instance = jQuery( this ).data( "datepicker" ),
          date = jQuery.datepicker.parseDate(
            instance.settings.dateFormat ||
            jQuery.datepicker._defaults.dateFormat,
            selectedDate, instance.settings );
        dates.not( this ).datepicker( "option", option, date );
    },
  });
});