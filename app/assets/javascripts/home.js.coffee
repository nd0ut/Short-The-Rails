# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  popup = $('#form-short-result')
  link = $('#form-short-result-link')
  error = $('#form-short-result-error')

  url_field = $('#form-short-url-field')
  url_field_hidden = $('#form-short-url-field-hidden')
  url_field_protocol = $('#form-short-url-protocol')

  timeout = 0

  url_field.focus()
  link.css('cursor', 'pointer')

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
      link.val('')
      error.html('')

    timeout = setTimeout((=>
      popup.slideUp(10)
      return
    ), 100)

    return
  )

  $('#form-short').on('ajax:success',(data, status, xhr) =>
    clearTimeout(timeout)

    error.fadeOut(50)
    link.fadeOut(50)

    setTimeout((=>
      popup.attr('class', 'alert alert-info')
      popup.slideDown() unless popup.is(':visible')

      link.attr('href', status['shorted_url'])
      link.val(status['shorted_url'])
      link.css('width', link.val().length * 8 + 'px')
      link.fadeIn()
      link.focus().select()

      return \
               ), 50)

    return
  )

  $('#form-short').on('ajax:error', (data, status, xhr) =>
      link.hide()

      setTimeout((=>
        popup.attr('class', 'alert alert-error')
        popup.slideDown() unless popup.is(':visible')

        error.html('Timeout was reached')
        error.fadeIn() \
                 ), 50)
  )

  $('#form-short-result-close').click(=>
    error.html('')
    link.val('')
    popup.slideUp(=> $('#form-short-url-field').focus())
  )

  link.click(->
    window.open(link.val(), '_blank')
  )

  $('#dropdown-protocol li a').each((index, elem) =>
    $(elem).click(=>
      $('#form-short-url-protocol').html(elem.innerHTML)
      return
    )
    return
  )

  return
