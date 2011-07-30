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
	//alert(id);

	dialog_name = 'food_dialog_' + id;

	$('#'+dialog_name).show();
}

// Food Dialog Bindings
$( function()
{
//binding radio buttons to calculate price
$(".sub_option").each(function()
{
	$(this).unbind('click');
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
		$("#total_price_active").val( parseFloat($("#total_price_active").val()) + parseFloat(price) - parseFloat(already_added) );
	});

});



		//binding checkboxes to show hide div
		$('.item_options').each( function( i )
			{
			$(this).click( function(e)
				{
				var div = $('#child_opts_' + $(this).attr('id'));
				var open = this.checked;
				if(! open){
				$("input:radio", div).each(
					function(i){
					this.checked = false;
					});     
				}
				div.slideToggle();
				});

			});

		});

