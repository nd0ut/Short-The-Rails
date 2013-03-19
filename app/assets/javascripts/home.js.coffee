# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  popup = $('#form-short-result')
  link = $('#form-short-result-link')
  error = $('#form-short-result-error')

  $('#form-short-url-field').focus()

  $('#form-short').on('ajax:before', =>
    $('#form-short-url-field-hidden').val($('#form-short-url-protocol').html() + $('#form-short-url-field').val())

    unless popup.is(':visible')
      link.html('')
      error.html('')
      popup.slideDown()

    return
  )

  $('#form-short').on('ajax:success',(data, status, xhr) =>
    error.fadeOut(50)
    link.fadeOut(50)

    if status['error'] != undefined
      setTimeout((=>
        popup.attr('class', 'alert')
        error.html(status['error'])
        error.fadeIn() \
                 ), 50)

    else
      setTimeout((=>
        popup.attr('class', 'well')
        link.attr('href', status['shorted_url'])
        link.html(status['shorted_url'])
        link.fadeIn() \
                 ), 50)

    return
  )

  $('#form-short-result-close').click(=>
    error.html('')
    link.html('')
    popup.slideUp(=> $('#form-short-url-field').focus())
  )