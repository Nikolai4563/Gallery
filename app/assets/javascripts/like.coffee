$(document).ready ->
  $('.likes').click ->
    image_id = $(this).attr('id')
    $.ajax(
      url: "/likes"
      data:
        image_id: image_id
      dataType: "json"
      type: "POST"
    ).success (response) ->
      console.log image_id