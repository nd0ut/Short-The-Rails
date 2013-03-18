# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#form-short').on('ajax:beforeSend', =>
    popup = $('#form-short-result')
    link = $('#shorted-url-link')
    error = $('#form-short-error')

    unless popup.is(':visible') then popup.slideDown()

    return
  )

  $('#form-short').on('ajax:success',(data, status, xhr) =>
    link = $('#shorted-url-link')
    popup = $('#form-short-result')
    error = $('#form-short-error')

    error.fadeOut(50)
    link.fadeOut(50)

    if status['error'] != undefined
      popup.attr('class', 'alert')

      setTimeout((=>
        error.html(status['error'])
        error.fadeIn() \
                 ), 50)

    else
      popup.attr('class', 'well')

      setTimeout((=>
        link.attr('href', status['shorted_url'])
        link.html(status['shorted_url'])
        link.fadeIn() \
                 ), 50)

    return
  )