
function cart_add( food_id )
{
	//alert(id);

/*	var data =
	{
		items:
		[{
			name: 	name,
			qty: 		2,
			price: 	price,

			options:
			[{
				name: 'Achaar Topping',
				price: 1,
			 },
			 {
				name: 'Extra Cheese',
				price: 1,
			 }]
		}]
	};*/

	var dlg = $('#food_dialog_'+food_id);

	var opts = $('.item_options',dlg);

	var options = Array();

	if ( opts.length )
	{
		opts.each( function(i) 
		{
			alert($('input.sub_option:checked',$(this)).attr('name'));
			
		});

	}

	/*$('#cart_item_template').mustache(data).appendTo('#cartify_items');

	$('#food_dialog_'+id).hide();*/
}
