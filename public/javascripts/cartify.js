
function cart_add( id, name, price )
{
	//alert(id);

	var data =
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
	};

	$('#cart_item_template').mustache(data).appendTo('#cartify_items');

	$('#food_dialog_'+id).hide();
}
