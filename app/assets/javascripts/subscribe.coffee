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
        alert response.success
      error: (xhr, status) ->
        if xhr.status == 401
          window.location = '/users/sign_in'
