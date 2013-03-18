# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#form-short').on('ajax:beforeSend', =>
    $('#form-short-result').slideDown()
    return
  )

  $('#form-short').on('ajax:success',(data, status, xhr) =>
    $('#form-short-result').html(status['shorted_url'])
    return
  )