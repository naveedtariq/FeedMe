
$(function(){

	// render current items in cart
	$.get('/orders/getcart', function(data){
			parse_cart(data);
		});
});


function parse_cart(data)
{
	ht = $('#cart_item_template').mustache(data);
	$('#cartify_items').html(ht);

	if (data.items.length > 0)
		$('#checkout_link').show();
}


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
			parse_cart(data);
	});

}




function place_order()
{
	var form = $('#form_card_info');

	$.ajax({
		url: '/orders/checkout',
		type: 'POST',
		data: form.serialize(),
		dataType: 'JSON',
		success: function(data) {
			//alert('hello');
			//form.slideToggle();
			msg = data.text;
			if ( data._error == 0 )
				msg = msg + '<a href="#" onclick="$(\'#card_info\').slideToggle();">Close [X]</a>';
			$('#card_transaction').html(msg);
			//setTimeout("$('#card_info').fadeOut(500)",7000);
		},

	});

	return false;
}

function show_card_dialog()
{
	var form = $('#form_card_info');
	form.show();
	$('#card_transaction').html('');
	$('#card_info').show();
}


function check_delivery()
{
	date = $('#date').val();
	time = $('#time').val();

	//142/01-21+21:30/77840/College+Station/1+Main+Street
	$.get( '/orders/candeliver',
	{
		date: date,
		time: time,
	},
	function(data)
	{
		if ( data.delivery == 1 )
		{
			$('#can_deliver').html('Delivery Available.');
			$('#can_deliver').css('color','green');
		  $("#placeorder_button").removeAttr('disabled');

			return;
		}

		$('#can_deliver').html('Delivery UnAvailable at This time, Please choose another time.');
		$('#can_deliver').css('color','red');
		$("#placeorder_button").attr('disabled', 'disabled');
	});

} // can_deliver()

function remove_item(id)
{
	$.get('/orders/remove',{id: id}, function(data){
			parse_cart(data);
			});
}
