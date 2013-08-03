$(document).ready ->
  $('.likes').click (event) ->
    image_id = $(this).attr('id')
    $.ajax
      url: "/likes"
      data:
        image_id: image_id
      dataType: "json"
      type: "POST"
      success: (response) ->
        $(event.currentTarget).toggleClass('dislike')
        $('.count-like').text(response.count)
      error: (xhr, status) ->
        if xhr.status == 401
          window.location = '/users/sign_in'
