
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

	// find the main food dialog
	dlg = $('#food_dialog_'+'364555');

	// find all sub options (checkboxes)
	opts = $('.item_options',dlg);

	console.log(opts);

	// if there are any options found
	if ( opts.length )
	{
		order = new Object;
		order.food_id = food_id;
		order.sub_options = Array();

		// loop through all of them
		opts.each( function(i)
		{
			// and if it's checked (selected)
			if ( $(this).attr('checked') )
			{
				order.sub_options[i] = new Object;

				// find it's name which would be ID of that item
				item_id = $(this).attr('name');

				order.sub_options[i].id = item_id;

				// using that ID find the DIV containing sub options(Radio buttons) for this item
				radio_div = $('#child_opts_'+item_id);

				// find all radio buttons and loop through each
				atleast_one_checked = false;
				$('input:radio', radio_div).each( function()
				{
					//console.log($(this).attr('id'));

					// we are only interested if it's checked
					if ( $(this).attr('checked') )
					{
						atleast_one_checked = true;
						order.sub_options[i].sub_option = this.id;
						//alert(this.id);
					}
				});

				if ( !atleast_one_checked )
				{
					//TODO: could be better way of telling user
					alert('You have to select atleast one option.');
					order = Array();
					return;
				}
			}

		});

		// get count of order and special instructions
		order.count = $('#count',dlg).val();
		order.instructions = $('#special_instructions',dlg).val();

		console.log(order);
		order_JSON = JSON.stringify(order);
		console.log(order_JSON);
	}

	/*$('#cart_item_template').mustache(data).appendTo('#cartify_items');

	$('#food_dialog_'+id).hide();*/
	$.post( '/orders', '[]', function(data) { alert(data.session_id); } );
}
