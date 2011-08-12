function cart_add( food_id , food_name, food_price )
{
	var new_food = function(id, name, price, count, instructions){
		return {id:id,name:name,price:price,count:count,instructions:instructions}
	}

	var new_option = function(id, name, price){
		return {id:id,name:name,price:price}
	}

	var get_option = function(ele){
			option = null;
			if ($(ele).attr('checked'))	{
				div = $('#child_opts_'+ele.id);
				$('input:radio', div).each( function(){
					if ($(this).attr('checked')){
						option = new_option(this.id, $(this).attr("option_name"), $(this).attr("price"));
					}
				});
			}
			return option;
	}

	dlg = $('#food_dialog_'+food_id);
	opts = $('.item_options',dlg);
	count = $('#count',dlg).val();
	instructions = $('#special_instructions',dlg).val();

	if ( opts.length ){
		order = new_food(food_id, food_name, food_price, count, instructions);
		order.options = Array();
		opts.each(function(){
			option = get_option(this);
			if(option){
				order.options.push(option);
			}
		});

		console.log(order);
		order_JSON = JSON.stringify(order);
		console.log(order_JSON);
	}

	/*$('#cart_item_template').mustache(data).appendTo('#cartify_items');

	$('#food_dialog_'+id).hide();*/
	$.post( '/orders', 'data='+order_JSON, function(data) { 
		ht = $('#cart_item_template').mustache(data);
		$('#cartify_items').html(ht);
	});

}
