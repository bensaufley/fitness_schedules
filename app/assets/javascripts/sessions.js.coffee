$(document).ready ->
	$('#user_type').hide()
	$('#user_type_switch').show()
	$('#user_type_switch div').on('click',( ->
		$('#user_type').val($(this).text())
		$('#user_type_switch .selected').removeClass('selected')
		$(this).addClass('selected')
	))
	$('#user_type').on('change',( ->
		console.log($(this).val())
		$('#user_type_switch #' + $(this).val().toLowerCase()).trigger('click')
	)).trigger('change')