// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require gritter


$(function () {
      if ($('#flash_notice').length > 0) {
        setTimeout(updateComments, 8000);
      }
    });

   function updateComments() {
     $.getScript('/converse.js');
     setTimeout(updateComments, 8000);
   }

//auto-complete
$(function () {
  $('#cf-home-search-form-searchText').autocomplete({
    minLength: 4,
    source : "/autocomplete/show"
  })
  });

$(function () {
$("#from_date").datepicker({
   changeMonth: true,
   dateFormat: 'yy-mm-dd'
   })
   $("#to_date").datepicker({
   changeMonth: true,
   dateFormat: 'yy-mm-dd'
   })
  });


$(function() {
// when the #region_id field changes
  $("#business_type_id").live('change', function() {

    $("#loading-bar-business-type").css('display','');

    setTimeout(function() {

    var type_id = $("#business_type_id").val();
    if(type_id == "") type_id ="0";

            if (type_id == 0) {
                $('#city-area-view').css('display','none');
                $('#sign-up-form-button').css('display','none')
            }

            if (type_id == 1) {
                $('#city-area-view').css('display','');
                $('#sign-up-form-button').css('display','');
                $("#merchant_city_id").prop('selectedIndex',0);
                $("#merchant_area_id").prop('selectedIndex',0);
            }
            if (type_id == 2) {
                $('#city-area-view').css('display','none');
                $('#sign-up-form-button').css('display','');
            }
    $("#loading-bar-business-type").css('display','none')}, 1000);

    return false;
  });
})

$(function() {
// when the #region_id field changes
  $("#merchant_city_id").live('change', function() {

    $("#loading-bar-city").css('display','');

    setTimeout(function() {

    // make a POST call and replace the content
    var city = $("#merchant_city_id").val();
    if(city == "") country="0";
    $.get('/merchants_lists/show_areas/' + city, function(data){
        $("#merchant-areas").html(data);
        $("#merchant_area_id").prop('selectedIndex',0);
    })

    $("#loading-bar-city").css('display','none')}, 1000);
    return false;
  });
})


$(function() {
$('#merchant_sign_up_form').live('submit',function() {

  $("#loading-bar-form").css('display','');

  setTimeout(function() {
  var type_id = $("#business_type_id").val();
  var city_id = $("#merchant_city_id").val();
  var area_id = $("#merchant_area_id").val();
  if(type_id == "") type_id ="0";
  if(city_id == "") city_id ="0";
  if(area_id == "") area_id ="0";
  $.get('/show_sign_up/' + type_id + '/' + city_id + '/' + area_id,function(data){
  $("#login-form").css('display','none');
  $("#cf-main").html(data).slideDown(5000);
  $('form[data-validate]').validate();
  })

  $("#loading-bar-form").css('display','none')}, 1000);

  return false;
});
})



$(function() {
$('#dashboard_range_form').live('submit',function() {

  $("#loading-bar-range-form").css('display','');

  setTimeout(function() {
  var from_date = $("#from_date").val();
  var to_date = $("#to_date").val();
  var vendor_id = $('#dashboard-vendor-id').data('vendor_id')
  var sub_category_id = $("#range_sub_category_id").val();

  if(from_date == "") from_date ="0";
  if(to_date == "") to_date ="0";
  if(sub_category_id == "") sub_category_id="0";
  if(vendor_id == "") vendor_id="0";
  $.get('/merchants_dashboard/range/' + from_date + '/' + to_date + '/' + vendor_id + '/' + sub_category_id,function(data) {
  $("#show-range-result").html(data)
  })
  $("#loading-bar-range-form").css('display','none')}, 1000);
  return false;
});
})


$(function() {
// when the #region_id field changes
  $("#dashboard_sub_category_id").live('change', function() {

    $("#loading-bar-dashboard").css('display','');

    setTimeout(function() {

    // make a POST call and replace the content
    var sub_category_id = $("#dashboard_sub_category_id").val();
    var vendor_id = $('#dashboard-vendor-id').data('vendor_id')
    if(sub_category_id == "") sub_category_id="0";
    if(vendor_id == "") vendor_id="0";
    $.get('/merchants_dashboard/categorize/' + sub_category_id + '/' + vendor_id, function(data){
        $("#show-impressions-clicks").html(data);

    })

    $("#loading-bar-dashboard").css('display','none')}, 1000);
    return false;
  });
})

$(function() {
  $("#cf-overview a").live("click", function() {
   			$.get('/footer/overview',function(data){
  			$("#cf-aboutus-main-content-center").html(data).slideDown(1000);
  			});
	return false;
    });
})

$(function() {
  $("#cf-whatwedo a").live("click", function() {
   			$.get('/footer/whatwedo',function(data){
  			$("#cf-aboutus-main-content-center").html(data).slideDown(1000);
  			});
	return false;
    });
})

$(function() {
  $("#cf-whatwebelieve a").live("click", function() {
   			$.get('/footer/whatwebelieve',function(data){
  			$("#cf-aboutus-main-content-center").html(data).slideDown(1000);
  			});
	return false;
    });
})

$(function() {
  $("#cf-c101 a").live("click", function() {
   			$.get('/footer/c101',function(data){
  			$("#cf-faq-main-content-id").html(data).slideDown(1000);
  			});
	return false;
    });
})


$(function() {
  $("#cf-faq a").live("click", function() {
   			$.get('/footer/cfaq',function(data){
  			$("#cf-faq-main-content-id").html(data).slideDown(1000);
  			});
	return false;
    });
})



$('#query').live('keyup',(function(e) {
    clearTimeout($.data(this, 'timer'));
    if (e.keyCode == 13 || e.keyCode == 8)
      search(true);
    else
      $(this).data('timer', setTimeout(search, 500));
})
);

function search(force) {
    var existingString = $("#query").val();
    if (!force && existingString.length < 3) return; //wasn't enter, not > 2 char
    $.get('/merchants_products/search/' + existingString)
      return false;
}

$(function() {
$(".catalogue-pagination-links a").live("click", function() {
    $.getScript(this.href);
    return false;
    });
});


$(function() {
$("#variable-product-listings a").live("click", function() {
    var pageNum = $(this).attr("href").match(/page=([0-9]+)/)[1];

    if ($('#variable-sub-category-id').data('sub_category_id')) {

    var sub_category_id = $('#variable-sub-category-id').data('sub_category_id');

       $.get('/merchants_financials/variable_paginate/page='+pageNum + '/sub_category_id='+sub_category_id,function(data){
  	$("#variable-product-listings").html(data);
  	});
    }
    else {

    sub_category_id = 0;

    $.get('/merchants_financials/variable_paginate/page='+pageNum + '/sub_category_id=0',function(data){
  	$("#variable-product-listings").html(data);
  	});

     }
   return false;
   });
})

$(function() {
// when the #region_id field changes
  $("#variable_table_categorize_id").live('change', function() {

    $("#loading-bar-dashboard-var").css('display','');

    setTimeout(function() {

    // make a POST call and replace the content
    var sub_category_id = $("#variable_table_categorize_id").val();
    if(sub_category_id == "") sub_category_id="0";

    $('#variable-sub-category-id').data('sub_category_id', sub_category_id);

    $.get('/merchants_financials/variable_categorize/sub_category_id=' + sub_category_id, function(data){
        $("#variable-product-listings").html(data);
    })

    $("#loading-bar-dashboard-var").css('display','none')}, 1000);
    return false;
  });
})

$(function() {
$("#fixed-product-listings a").live("click", function() {
    var pageNum = $(this).attr("href").match(/page=([0-9]+)/)[1];

    if ($('#fixed-sub-category-id').data('sub_category_id')) {

    var sub_category_id = $('#fixed-sub-category-id').data('sub_category_id');

       $.get('/merchants_financials/fixed_paginate/page='+pageNum + '/sub_category_id='+sub_category_id,function(data){
  	$("#fixed-product-listings").html(data);
  	});
    }
    else {

    sub_category_id = 0;

    $.get('/merchants_financials/fixed_paginate/page='+pageNum + '/sub_category_id=0',function(data){
  	$("#fixed-product-listings").html(data);
  	});

     }
   return false;

    });
})

$(function() {
// when the #region_id field changes
  $("#fixed_table_categorize_id").live('change', function() {

    $("#loading-bar-dashboard-var").css('display','');

    setTimeout(function() {

    // make a POST call and replace the content
    var sub_category_id = $("#fixed_table_categorize_id").val();
    if(sub_category_id == "") sub_category_id="0";

    $('#fixed-sub-category-id').data('sub_category_id', sub_category_id);

    $.get('/merchants_financials/fixed_categorize/sub_category_id=' + sub_category_id, function(data){
        $("#fixed-product-listings").html(data);
    })

    $("#loading-bar-dashboard-var").css('display','none')}, 1000);
    return false;
  });
})

$(function() {
$("#purchase-product-listings a").live("click", function() {
    var pageNum = $(this).attr("href").match(/page=([0-9]+)/)[1];

    if ($('#purchase-sub-category-id').data('sub_category_id')) {

    var sub_category_id = $('#purchase-sub-category-id').data('sub_category_id');

       $.get('/merchants_financials/purchase_paginate/page='+pageNum + '/sub_category_id='+sub_category_id,function(data){
  	$("#purchase-product-listings").html(data);
  	});
    }
    else {

    sub_category_id = 0;

    $.get('/merchants_financials/purchase_paginate/page='+pageNum + '/sub_category_id=0',function(data){
  	$("#purchase-product-listings").html(data);
  	});

     }
   return false;

    });
})

$(function() {
// when the #region_id field changes
  $("#purchase_table_categorize_id").live('change', function() {

    $("#loading-bar-dashboard-pur").css('display','');

    setTimeout(function() {

    // make a POST call and replace the content
    var sub_category_id = $("#purchase_table_categorize_id").val();
    if(sub_category_id == "") sub_category_id="0";

    $('#purchase-sub-category-id').data('sub_category_id', sub_category_id);

    $.get('/merchants_financials/purchase_categorize/sub_category_id=' + sub_category_id, function(data){
        $("#purchase-product-listings").html(data);
    })

    $("#loading-bar-dashboard-pur").css('display','none')}, 1000);
    return false;
  });
})



$(function() {
$("#i-c-product-listings a").live("click", function() {
    var pageNum = $(this).attr("href").match(/page=([0-9]+)/)[1];

    if ($('#i-c-sub-category-id').data('sub_category_id')) {

    var sub_category_id = $('#i-c-sub-category-id').data('sub_category_id');

       $.get('/merchants_financials/i_c_paginate/page='+pageNum + '/sub_category_id='+sub_category_id,function(data){
  	$("#i-c-product-listings").html(data);
  	});
    }
    else {

    sub_category_id = 0;

    $.get('/merchants_financials/i_c_paginate/page='+pageNum + '/sub_category_id=0',function(data){
  	$("#i-c-product-listings").html(data);
  	});

     }
   return false;

    });
})

$(function() {
// when the #region_id field changes
  $("#i_c_table_categorize_id").live('change', function() {

    $("#loading-bar-dashboard-pur-imp").css('display','');

    setTimeout(function() {

    // make a POST call and replace the content
    var sub_category_id = $("#i_c_table_categorize_id").val();
    if(sub_category_id == "") sub_category_id="0";

    $('#i-c-sub-category-id').data('sub_category_id', sub_category_id);

    $.get('/merchants_financials/i_c_categorize/sub_category_id=' + sub_category_id, function(data){
        $("#i-c-product-listings").html(data);
    })

    $("#loading-bar-dashboard-pur-imp").css('display','none')}, 1000);
    return false;
  });
})

$(function() {
  $("#current_category a").live("click", function() {
    $.getScript(this.href);

    });
});

$(function(){
	var deletesuccess=$("#delete-notification").css("display");
	var deleteclose=$("#delete-close-notification").css("display");
	var editsuccess=$("#edit-notification").css("display");
	var editclose=$("#edit-close-notification").css("display");
	var createsuccess=$("#create-notification").css("display");
	var createclose=$("#create-close-notification").css("display");
	var createsuggestion=$("#speaktous-notification").css("display");
	var nocreatesuggestion=$("#speaktous-no-notification").css("display");

	$.extend($.gritter.options, {
		    class_name: 'gritter-light',
		    position: 'top-right',
                    fade_in_speed: 800, // how fast notifications fade in (string or int)
		    fade_out_speed: 800, // how fast the notices fade out
		    time: 6000 // hang on the screen for...
		});

	if(deletesuccess=="inline")
	{
		$.gritter.add({
				title: 'Delete request submitted!',
				text: 'Your request for deleting this product has been submitted successfully',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
			});
		return false;
	}
	if(createsuggestion=="inline")
	{
		$.gritter.add({
				title: 'Request submitted!',
				text: 'We have received your request. We will get back to you soon. Thanks!',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
			});
		return false;
	}
	if(nocreatesuggestion=="inline")
	{
		$.gritter.add({
				title: 'Request not submitted!',
				text: 'Sorry! There was an error while submitting your request. Please try again.',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
			});
		return false;
	}
	if(deleteclose=="inline")
	{
		$.gritter.add({
				title: 'Info!',
				text: 'Request to delete this product is not submitted!Try Again',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
			});
		return false;
	}
	if(editsuccess=="inline")
	{
		$.gritter.add({
				title: 'Edit request submitted!',
				text: 'Your request for editing this product has been submitted successfully',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
			});
		return false;
	}
	if(editclose=="inline")
	{
		$.gritter.add({
				title: 'Info!',
				text: 'Request to edit this product is not submitted!Try again',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
			});
		return false;
	}
	if(createsuccess=="inline")
	{
		$.gritter.add({
				title: 'Create request submitted!',
				text: 'Request to create this product is submitted!',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
			});
		return false;
	}
	if(createclose=="inline")
	{
		$.gritter.add({
				title: 'Info!',
				text: 'Request to create this product is not submitted!Try again',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
			});
		return false;
	}
});

// test scripts
$(function() {
  $("#target a").live("click", function() {
    $.getScript(this.href);
    return false;
    });
});

function hide_div()
{
  $("#target_div").hide();
}
// test end

