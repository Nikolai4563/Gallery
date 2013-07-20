$(document).ready ->
  $('.subscribe-block').click (event) ->
    category_id = $(this).attr('id')
    $.ajax
      url: "/subscribes"
      data:
        category_id: category_id
      dataType: "json"
      type: "POST"
      success: (response) ->
        $(event.currentTarget).find('.subscribe').toggleClass('describe')
      error: (xhr, status, error) ->
        length = (xhr.responseText.length) - 2
        $('#main .container').prepend('<div class="alert alert-error">'+ xhr.responseText.substring(10, length)+'<a class="close" data-dismiss = "alert">×</a></div>')
