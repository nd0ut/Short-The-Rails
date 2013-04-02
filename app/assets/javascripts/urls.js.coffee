# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#urls_table_body .delete').each((i, item)->
    $(item).click(->
      bootbox.confirm("Are you sure?", (result)->
        if result
          $.ajax 'urls/' + $(item).attr('data-id') + '.json',
                 type: 'delete'
                 success: (data)->
                   if data.status == 'success'
                     setTimeout(->
                       $(item).parent().parent().fadeOut()
                     , 100)
                   else if data.status == 'error'
                     bootbox.alert('Error: ' + data.discription)
                 error: ->
                   bootbox.alert('Deleting fails')
          return
      )
      return
    )
    return
  )
  return

