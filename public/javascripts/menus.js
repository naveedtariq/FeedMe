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
