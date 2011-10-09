function display_menu(id)
{
	//alert(id);
	
//	$('#menu_categories').slideToggle();
	var old_showing = $('.active_menu'); 
	if(old_showing){
		old_showing.removeClass('active_menu');
		old_showing.slideToggle();
	}
	$('.menu_'+id).slideToggle();
	$('.menu_'+id).addClass('active_menu');
//	document.getElementById( "link_title" ).setAttribute('onclick', 'display_menu('+id+');');
}

/*function hide_menu(id)
	{
	$('#menu_categories').slideToggle();
	$('.menu_'+id).slideToggle();
	}*/

function show_menu_item(id)
{
	//alert( 'About to show dialog:' + id );
	var already = $('.showing_dialog');
	if(already){
		already.hide();
		already.removeClass('showing_dialog');
	}
	dialog = $('#food_dialog_' + id);
	dialog.addClass("showing_dialog");

	var height = $(window).height();
	var width = $(window).width();
	console.log(height);
	console.log(width);

	dialog.css({
			'position': 'fixed',
			'left' : width/2 - (dialog.width() / 2),  // half width - half element width
			'top' : height/2 - (dialog.height() / 2)-150, // similar
			'z-index' : 15,                        // make sure element is on top
	});

//	dialog.position({
//			of : $("body"),
//			my: "center center",
//			at: "center center"
//	});

	$('input#total_price',dialog).attr('class','active_price');
	dialog.show();
}

function hide_food_dialog(id)
{
	//alert( 'About to hide dialog:' + id );
	var dialog = $('#'+id);

	$('input.active_price',dialog).attr('class','unactive');
	dialog.hide();
}

$( function()
{
	// Food Dialog Bindings
	//binding radio buttons to calculate price
	$(".sub_option").each(function()
	{
		//$(this).unbind('click');
		var price = $(this).attr("price");

		$(this).click( function()
		{
			var selected_id = $("input:hidden", $(this).parent());
			var already_added = 0;

			if( selected_id.val() != 'nil' )
			{
				already_added = $("#"+selected_id.val()).attr("price");
			} 

			selected_id.val(this.id);
			$("input.active_price").val( parseFloat($("input.active_price").val()) + parseFloat(price) - parseFloat(already_added) );
		});

	});



	//binding checkboxes to show hide div
	$('.item_options').each( function( i )
		{
		$(this).click( function(e)
			{
			var div = $('#child_opts_' + $(this).attr('id'));
			var open = this.checked;
			if(!open)
			{
				var added_item = $('input:hidden',div);
				var already_added_price = 0;

				if ( added_item.val() != 'nil' )
				{
					already_added_price = $('#'+added_item.val()).attr('price');
					added_item.val('nil');
				}

				// since we are unchecking all radio boxes we have to reset the price added
				$("input.active_price").val( parseFloat($("input.active_price").val()) - parseFloat(already_added_price) );
					
				$("input:radio", div).each( function()
				{
					this.checked = false;
				});     
			}
			div.slideToggle();
			});

		});

});

