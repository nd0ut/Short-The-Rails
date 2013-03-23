# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery.fn.selectText = ->
  if (document.body.createTextRange)
    range = document.body.createTextRange()
    range.moveToElementText(this[0])
    range.select()
  else if (window.getSelection)
    selection = window.getSelection()
    range = document.createRange()
    range.selectNodeContents(this[0])
    selection.removeAllRanges()
    selection.addRange(range)

jQuery ->
  popup = $('#form-short-result')
  link = $('#form-short-result-link')
  error = $('#form-short-result-error')

  url_field = $('#form-short-url-field')
  url_field_hidden = $('#form-short-url-field-hidden')
  url_field_protocol = $('#form-short-url-protocol')

  url_field.focus()

  url_field.keyup(=>
    protocol = url_field.val().match(/^(http|https|ftp|mailto|magnet)(?::)(?:\/\/|\?)?(?=[a-zA-Z0-9])/ig)

    if protocol
      url_field.val(url_field.val().replace(protocol, ''))
      url_field_protocol.html(protocol)
  )

  $('#form-short').on('ajax:before', =>
    if url_field.val().length
      url_field_hidden.val(url_field_protocol.html().trim() + url_field.val().trim())
    else
      url_field_hidden.val(url_field_protocol.html().trim() + url_field.attr('placeholder'))

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
        link.focus()
        link.selectText()
        link.fadeIn() \
                 ), 50)

    return
  )

  $('#form-short-result-close').click(=>
    error.html('')
    link.html('')
    popup.slideUp(=> $('#form-short-url-field').focus())
  )

  $('#dropdown-protocol li a').each((index, elem) =>
    $(elem).click(=>
      $('#form-short-url-protocol').html(elem.innerHTML)
      return
    )
    return
  )

  return
