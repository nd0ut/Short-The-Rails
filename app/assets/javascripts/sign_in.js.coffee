jQuery ->
  $('.modal').on('shown', ->
    $(this).find('[autofocus]:first').focus()
  )

  sign_in_form = $('#sign-in-form')

  sign_in_form.on('ajax:success', (data, xhr, status) ->
    if xhr.success != false
      $('#sign-in-modal').modal('hide')
      $('.navbar').html(xhr)
  )