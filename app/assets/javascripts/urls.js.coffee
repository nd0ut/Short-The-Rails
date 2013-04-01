# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  tbody = $('#urls_table_body')

  $.ajax({
    url: '/urls.json'
         }
  ).done((urls) ->
    for url in urls
      tbody.append('<tr/>')

      tr.append('<td/>').html(url.original)
      tr.append('<td/>').html(url.shorted)
    return
  )
  return
