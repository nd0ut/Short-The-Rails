jQuery ->
  $('.modal').on('shown', ->
    $(this).find('[autofocus]:first').focus()
  )

  sign_up_form = $('#sign-up-form')

  sign_up_form.validate({
    rules:{
      'user[username]': {
        minlength: 2,
        required: true
      },
      'user[email]': {
        email: true,
        required: true
      },
      'user[password]': {
        minlength: 5,
        required: true
      },
      'user[password_confirmation]': {
        equalTo: "#sign-up-form #user_password",
        required: true
      }

    },
    highlight: (element) ->
      $(element).closest('.control-group').removeClass('success').addClass('error')
    success: (element) ->
      element
        .text('OK!').addClass('valid')
        .closest('.control-group').removeClass('error').addClass('success')
  })

  sign_up_form.on('ajax:before', ->
    sign_up_form.find('.control-group').each(->
      $(this).removeClass('error')
    )
  )

  sign_up_form.on('ajax:success', (data, xhr, status) ->
    if xhr.success != false
      $('#sign-up-modal').modal('hide')
      $.remove
  )