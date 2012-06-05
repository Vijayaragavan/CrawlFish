

// functions defined after this section are direct
//#=============== Direct Functions - START ================

// This function is triggered when the city select box in specific page changes
$(function() {

  $("#city_id").live('change', function() {

    $("#loading-bar-city").css('display','');

    setTimeout(function() {

    var city = $("#city_id").val();
    if(city == "") country="0";
    $.get('/bnm/show_areas/' + city, function(data){
        $("#areas").html(data);
        $("#area_id").prop('selectedIndex',0);
        $("#areas").css('display','')
         $("#choose").css('display','')
    })

    $("#loading-bar-city").css('display','none')}, 1000);

    return false;
  });
})

// This function is triggered when the area select box in specific page changes
$(function() {
  $("#area_id").live('change', function() {

    $("#loading-bar-area").css('display','');
    $("#loading-bar-grid").css('display','');
    $("#final-local-grid").css('display','none');
    setTimeout(function() {

    var product_id = $('#local-grid').data('product_id')
    var sub_category_id = $('#local-grid').data('sub_category_id')
    var area = $("#area_id").val();
    if(area == "") area="0";
    $.get('/bnm/show_local_shops/area_id=' + area + '/product_id=' + product_id + '/sub_category_id=' + sub_category_id, function(data){
        $("#local-grid").html(data);
        var TabbedPanels1= new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: 1});
        $('#view-all-local').css('display','')
        impressions_logger("#final-local-grid");
        var area_name = $('table#tbl-local-inner').data('area');
	area_name = area_name.toLowerCase().replace(/\b[a-z]/g, function(letter) {
    	return letter.toUpperCase();
	});
        $("#loading-bar-area").css('display','none');
	$("#loading-bar-grid").css('display','none');
	$("#final-local-grid").css('display','');
	$.gritter.add({
				title: 'Shops in ' +area_name+ ',Chennai',
				text: 'Displaying price information from all local shops in ' + area_name + ',Chennai',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
				before_open: function(){
		                        if($('.gritter-item-wrapper').length == 1)
        	    		        {
        	    		           return false;
        	            		}
                		}
			});
	return false;
    	})


	}, 2000);

    return false;
  });
})

// This function is triggered when view_all_local link is clicked after selecting area select box in specific page changes
$(function() {
  $("#view-all-local a").live("click", function() {
    out_of_stock("#view-all-local",0,"#local-grid",$(this).attr("href"),0);
    $.gritter.add({
				title: 'Shops in Chennai!',
				text: 'Displaying price information from all local shops in Chennai',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
				before_open: function(){
		                        if($('.gritter-item-wrapper').length == 2)
        	    		        {
        	    		           return false;
        	            		}
                		}
			});

    return false;
    });
})

// This function is triggered when pagination link of local grid is clicked

$("#local-grid-pagination-links a").live("click", function() {

   out_of_stock(0,0,"#local-grid",$(this).attr("href"));

   return false;

});

// This function is triggered when pagination link of online grid is clicked

$("#online-grid-pagination-links a").live("click", function() {

   out_of_stock(0,0,"#online-grid",$(this).attr("href"));
   return false;

});


// This function is triggered when include out of stock link is clicked in online tab
$("#online-include-out-of-stock a").live("click", function() {

   out_of_stock("#online-include-out-of-stock","#online-exclude-out-of-stock","#online-grid",$(this).attr("href"));
    $.gritter.add({
				title: 'Include Out of Stock',
				text: 'Displaying price information from online shops including out of stock products',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
				before_open: function(){
		                        if($('.gritter-item-wrapper').length == 2)
        	    		        {
        	    		           return false;
        	            		}
                		}
			});
   return false;

});

// This function is triggered when exclude out of stock link is clicked in online tab
$("#online-exclude-out-of-stock a").live("click", function() {

   out_of_stock("#online-exclude-out-of-stock","#online-include-out-of-stock","#online-grid",$(this).attr("href"));
   $.gritter.add({
				title: 'Exclude Out of Stock',
				text: 'Displaying price information from online shops excluding out of stock products',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
				before_open: function(){
		                        if($('.gritter-item-wrapper').length == 2)
        	    		        {
        	    		           return false;
        	            		}
                		}
			});
   return false;

});

// This function is triggered when include out of stock link is clicked in local tab
$("#local-include-out-of-stock a").live("click", function() {

   out_of_stock("#local-include-out-of-stock","#local-exclude-out-of-stock","#local-grid",$(this).attr("href"));
   $.gritter.add({
				title: 'Include Out of Stock',
				text: 'Displaying price information from local shops including out of stock products',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
				before_open: function(){
		                        if($('.gritter-item-wrapper').length == 2)
        	    		        {
        	    		           return false;
        	            		}
                		}
			});
   return false;

});

// This function is triggered when exclude out of stock link is clicked in local tab
$("#local-exclude-out-of-stock a").live("click", function() {

   out_of_stock("#local-exclude-out-of-stock","#local-include-out-of-stock","#local-grid",$(this).attr("href"));
   $.gritter.add({
				title: 'Exclude Out of Stock',
				text: 'Displaying price information from local shops excluding out of stock products',
				image: '/Images/CF_logoChart_v1.png',
				sticky: false,
				before_open: function(){
		                        if($('.gritter-item-wrapper').length == 2)
        	    		        {
        	    		           return false;
        	            		}
                		}
			});
   return false;

});

$(function() {
$("#TabbedPanels1 li:eq(0)").on("click",function() {

   impressions_logger("#final-online-grid");
   return false;
});
$("#TabbedPanels1 li:eq(1)").on("click",function() {

   impressions_logger("#final-local-grid");
   return false;

});
});

$(function() {
$("#final-online-grid").ready(function() {

   impressions_logger("#final-online-grid");
   return false;

});
});

$("td#online-visit-shop a").live("click", function() {

   var online_shop_link =  $(this).attr("href");

   clicks_logger("#online-visit-shop",online_shop_link,"online");

   return false;

});

$("td#local-visit-shop a").live("click", function() {

   var local_shop_link =  $(this).attr("href");

   clicks_logger("#local-visit-shop",local_shop_link,"local");

   return false;

});

//#=============== Direct Functions - END ================

// functions defined after this section are auxillary
//#=============== Auxillary Functions - START ================
function out_of_stock(clicked_div_id,div_id_to_show,grid_div_id,href_attr) {

  var product_id = href_attr.match(/product_id=([0-9]+)/)[1];
  var sub_category_id = href_attr.match(/sub_category_id=([0-9]+)/)[1];
  var include = href_attr.match(/include=([0-9]+)/)[1];
  var type = href_attr.match(/type=([a-z]+)/)[1];
  if (href_attr.match(/page=([0-9]+)/) != null){
        var page = href_attr.match(/page=([0-9]+)/)[1];
  }
  else{
        var page = 0;
  }
  if (href_attr.match(/area_id=([0-9]+)/) != null){
        var area_id = href_attr.match(/area_id=([0-9]+)/)[1];
  }
  else
  {
        var area_id = 0;
  }

  $.get('/specific/include_exclude_view_all_local/product_id=' + product_id + '/sub_category_id=' + sub_category_id + '/include=' + include + '/type=' + type +'/area_id=' + area_id + '/page=' + page , function(data){
        $(grid_div_id).html(data);

        $(clicked_div_id).css('display','none');
        $(div_id_to_show).css('display','inline');

        if (type == "local")
        {

          impressions_logger("#final-local-grid");

         }
         else if (type == "online")
         {

          impressions_logger("#final-online-grid");

         }
    });

}

function impressions_logger(current_div_id) {

  var unique_ids_array = $(current_div_id).data('unique_ids_array');

    if (unique_ids_array.length != 0){

        $.post('/impressions/' + "impressions" + "/" + unique_ids_array);

    }

}

function clicks_logger(current_div_id,link,type) {

  var unique_id = $(current_div_id).data('unique_id');
 
    if (unique_id.length != 0){

        $.post('/clicks/' + "clicks" + "/" + unique_id ,function(data) {

          if (type == "online"){
            window.location = "http://"+link
          }
          else if (type == "local"){
            window.location = link
          }

        });
    }
}

//#=============== Auxillary Functions - END ================

