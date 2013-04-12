jQuery ->
  $('.navbar .logout').on('ajax:success', (data, xhr, status) ->
    if xhr.success != false
      $('.navbar').html(xhr)
  )