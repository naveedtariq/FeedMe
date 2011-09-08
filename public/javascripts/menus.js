function display_menu(id)
{
	//alert(id);

	$('#menu_categories').slideToggle();
	$('.menu_'+id).slideToggle();
}

/*function hide_menu(id)
	{
	$('#menu_categories').slideToggle();
	$('.menu_'+id).slideToggle();
	}*/

function show_menu_item(id)
{
	//alert( 'About to show dialog:' + id );

	dialog = $('#food_dialog_' + id);

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

