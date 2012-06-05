$(function() {
$("#TabbedPanelsLocal1 li:eq(1)").on("click",function() {

   var local_shop_area_id = $("#local_shop_area_id").val();

  if (local_shop_area_id < 1) {

          alert("Please select an area!")

  }
  else{
          var branch_name = $("#local_shop_area_id option[value='"+local_shop_area_id+"']").text()
          var vendor_name = $("input#input-vendor-name").attr("vendor_name")
          $('#gmap-error').css('display','none')
          $.get('/local/show_gmap/' + vendor_name + '/' + branch_name, function(data){
                $("#gmap").html(data);
            });
    }

   return false;

});
});

$(function() {
  $("form.view-map-button").live('submit', function() {

  var local_shop_area_id = $("#local_shop_area_id").val();

  if (local_shop_area_id < 1) {

          alert("Please select an area!")

  }
  else{
          var branch_name = $("#local_shop_area_id option[value='"+local_shop_area_id+"']").text()
          var vendor_name = $("input#input-vendor-name").attr("vendor_name")
          $('#gmap-error').css('display','none')
          $.get('/local/show_gmap/' + vendor_name + '/' + branch_name, function(data){
                $("#gmap").html(data);
            });

            var TabbedPanelsLocal1= new Spry.Widget.TabbedPanels("TabbedPanelsLocal1", { defaultTab: 1});

    }

    return false;
  });
})

$(function() {
// when the #region_id field changes
  $("#local_shop_area_id").live('change', function() {

    var vendor_id = $('#local_shop_area_id').val();
    if(vendor_id == "") vendor_id="0";
    $.get('/local/change_vendor_details/'  + vendor_id, function(data){
        $("#local-shop-details").html(data);
    })
 
    var branch_name = $("#local_shop_area_id option[value='"+vendor_id+"']").text()
    var vendor_name = $("input#input-vendor-name").attr("vendor_name")
    $('#gmap-error').css('display','none')
    $.get('/local/show_gmap/' + vendor_name + '/' + branch_name, function(data){
      $("#gmap").html(data);
	var TabbedPanelsLocal1= new Spry.Widget.TabbedPanels("TabbedPanelsLocal1", { defaultTab: 0});
    })
	 
   
    return false;

  });
})

$(function() {
// when the #region_id field changes
  $("#send-sms-text-button a").live('click', function() {

  $("#send-sms-text-button").css('display','none')

  $("input#type_mobile").prop('checked', false);

  $("input#type_landline").prop('checked', false);

    return false;

  });
})

$(function() {
// when the #region_id field changes
  $("#send-sms-success-message a").live('click', function() {

  $("#send-sms-success-message").css('display','none')

    return false;

  });
})

$(function() {
// when the #region_id field changes
  $("input#type_mobile").live('change', function() {

  $("#send-sms-text-button").css('display','inline')

    return false;
  });
})

$(function() {
// when the #region_id field changes
  $("input#type_landline").live('change', function() {

  $("#send-sms-text-button").css('display','inline')

    return false;
  });
})


$(function() {

  $("#send_sms_form").live("submit", function() {

  var type = $("input[name=type]:checked").val();

  var phone_number = $("#phone-number").val();

  var product_id = $("#send_sms_product_id").val();

  var sub_category_id = $("#send_sms_sub_category_id").val();

  var vendor_id = $("#send_sms_vendor_id").val();

  if(vendor_id == "") vendor_id="0";

  if(product_id == "") product_id="0";

  if(sub_category_id == "") sub_category_id="0";

  $.post('/local/send_sms/'  + type + '/' + phone_number + '/' + vendor_id + '/'+ product_id +'/' + sub_category_id, function(data){

  $("#send-sms-text-button").css('display','none')

  $("input#type_mobile").prop('checked', false);

  $("input#type_landline").prop('checked', false);

  $("#send-sms-success-message").css('display','inline')

    })

    return false;
  });
})

