$(document).ready ->
	$user_type=$('<input />',
		'id': 'user_type',
		'name': $('#user_type').attr('name')
		'type' : 'hidden',
		'value' : $('#user_type').val())
	$('#user_type').remove()
	$user_type.prependTo('#signin form')
	$('#user_type_switch #' + $user_type.val().toLowerCase()).addClass('selected')
	$('#user_type_switch').show()
	$('#user_type_switch div').on('click',( ->
		$('#user_type').val($(this).text())
		$('#user_type_switch .selected').removeClass('selected')
		$(this).addClass('selected')
	))