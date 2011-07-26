function display_menu(id)
{
	//alert(id);

	$('#menu_categories').slideToggle();
	$('.menu_'+id).slideToggle();
}

function hide_menu(id)
{
	$('#menu_categories').slideToggle();
	$('.menu_'+id).slideToggle();
}
