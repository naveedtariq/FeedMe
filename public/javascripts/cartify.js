
$(function(){
	update_cart();
});

var colors = {"notice" : "#57A957", "message" : "#339BB9", "error" : "#C43C35" }
function notify(msg, options){
	var defaults = {type : "message", fo : false}
	$.extend(defaults, options);

	if( $('.checkout-notify').is(':visible') ) {
		$(".checkout-notify").hide();
	}	
	$('.checkout-notify').css('background-color', colors[defaults.type]);
	$('.checkout-notify').css('border', '1px solid ' +colors[defaults.type]);
	$('.checkout-notify').html(msg);
	if(defaults.fo){
		$('.checkout-notify').fadeIn(); 	
	}
	else{
		$('.checkout-notify').fadeIn().delay(2000).fadeOut('slow'); 	
	}
}


function loading(tellme)
{
	if ( tellme )
	{
		$('#ploader').fadeIn('slow');
		$('input',$('#card_info')).attr('readonly','readonly');

		return;
	}

	$('#ploader').fadeOut('slow');
	$('input',$('#card_info')).removeAttr('readonly');
}

// render current items in cart
function update_cart()
{
	$.get('/orders/getcart', function(data){
			parse_cart(data);
      $("#date").datetimepicker({
          ampm: true
        });
      $("#tipercent").val(data.tipercent);
		});
}
function show_full_cart(){
	var showing = $('.showing');
	if(showing.length > 0){
		$('#view_details_link').html('Show Details');
		$('#view_details_link').removeClass('showing');
	}
	else{
		$('#view_details_link').html('Hide Details');
		$('#view_details_link').addClass('showing');
	}	
	$('#cart_details').slideToggle();
	return false;
}
function empty_cart()
{
	$.get('/orders/emptycart',function(data){
		update_cart();
	});
}

var cart_view = function(data){
	
	var view = { items : data.items,
				 total : data.total,
				 fulltotal : data.fulltotal,
				 tax : data.tax,
				 fee : data.fee,
         tip : data.tip, 
         tipercent : data.tipercent,
				 itemcount : data.items.length,
			     user_id : data.user_id
	}
	return view;
}
function parse_cart(data)
{
	ht = $('#cart_item_template').mustache(cart_view(data));
	$('#cartify_items').html(ht);

	if (data.items.length > 0)
	{
//		$('div.cart_item').animate({backgroundColor: '#FFF'},1000);
		$('#checkout_link').show();
	}
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

	order = new_food(food_id, food_name, food_price, count, instructions);

	if ( opts.length ){
		order.options = Array();
		opts.each(function(){
			option = get_option(this);
			if(option){
				order.options.push(option);
			}
		});

	}
  tip = $("#tipercent option:selected").val();
  if(tip)
  {
    order.tip = tip;
  }
  else
  {
    order.tip = 5;
  }

	console.log(order);
	order_JSON = JSON.stringify(order);
	console.log(order_JSON);
	$.post( '/orders', 'data='+order_JSON, function(data) { 
			parse_cart(data);
			dlg.hide();
      $("#tipercent").val(tip);
	});

}




function place_order()
{

  var email = $('#email').val();
  var phone = $('#phone').val();
	if ( email == "")
	{
		notify('Please provide your email address.', {type : "error"});
		return;
	}
	if ( phone == "")
	{
		notify('Please provide your contact number. Format XXX-XXX-XXXX', {type : "error"});
		return;
	}
	var form = $('#form_card_info');
	notify("Please Wait...",{fo : true});

	$.ajax({
		url: '/orders/checkout',
		type: 'POST',
		data: form.serialize(),
		dataType: 'JSON',
		success: function(data) {
			$(".checkout-notify").hide();
			msg = data.text;
			if ( data._error == 1 )
			{
				notify(msg, {type : "error"});
				return false;
			}

			msg = msg;
			notify(msg, { type : "notice" });
//			$('#card_transaction').html(msg);

//			empty_cart();
			$('#checkout_cancel').val('Close');
			$('#checkout_cancel').animate({ left: '190', });
			$("#placeorder_button").hide();
			$('#checkout_avail').hide();
      window.location = "/orders/thankyou";
		},

	});

	return false;
}



function show_card_dialog()
{
  window.location = "/orders/checkout_confirmation";
  return;
	var form = $('#card_info');

	var height = screen.height;
	var width = screen.width;
	console.log(height);
	console.log(width);

	form.css({
			'position': 'fixed',
			'left' : width/2 - (form.width() / 2)-280,  // half width - half element width
			'top' : height/2 - (form.height() / 2)-100, // similar
			'z-index' : 15,                        // make sure element is on top
	});

	form.show();
	$('#card_transaction').html('');
	$('#card_info').show();
}


function check_delivery()
{

  var date = $('#date').val();
  var time = $('#time').val();
	if ( date == "")
	{
		notify('Please set date and time first', {type : "error"});
		return;
	}

	var checkout_butt = $("#place_order");
//	notify('Please Wait...', {fo: true, type : "message"});
//	loading(true);

	$.get( '/orders/candeliver', { date: date, time: time, }, function(data){
	
		$('#dialog_notice').hide();

		if ( data.delivery == 1 )
		{
			notify('Delivery Available.', {type : "notice"});

		  checkout_butt.removeAttr('disabled');
			checkout_butt.css('color','#FFF');

			return;
		}

		notify(data.msg, {type : "error"});

		checkout_butt.attr('disabled', 'disabled');
		checkout_butt.css('color','#AAA');
	});

} // can_deliver()

function remove_item(id)
{

  tip = $("#tipercent option:selected").val();
	$.get('/orders/remove',{id: id}, function(data){
			parse_cart(data);
      $("#tipercent").val(tip);
			});
}

function update_quantity(quantity,id)
{
  tip = $("#tipercent option:selected").val();
	$.get('/orders/update_cart_item',{id: id,quantity: quantity}, function(data){
			parse_cart(data);
      $("#tipercent").val(tip);
			});

}

function update_tip(tipercent)
{
	$.get('/orders/update_tip',{tipercent: tipercent}, function(data){
			parse_cart(data);
      $("#tipercent").val(tipercent);
			});

}
