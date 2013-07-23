send_image = new Array()
category_id = 0
$(document).ready ->

  $('.image').click ->
    if $(this).hasClass('upload')
      $(this).removeClass('upload')
      $(this).parent().find('.category-select').removeClass('show')
    else
      $(this).addClass('upload')
      $(this).parent().find('.category-select').addClass('show')

  $('.category-select option').click ->
    category = $(this).text()
    $(this).closest('.select-image').find('img').clone().appendTo('.category.'+category)
    $(this).closest('.select-image').remove()

  $('.category').on "click", "img", ->
    $(this).remove()


  $('.category .send-images').on "click", ->
    send_image=[]
    category_id = $(this).parent().attr('id')
    $(this).parent().find('img').each (index, val) ->
      send_image[index] = val.src

    $.ajax(
      url: "/admin/parse/save_img"
      beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")

      data:
        send_image: send_image
        category_id: category_id
      dataType: "json"
      type: "POST"
    ).success (response) ->
      $('#'+category_id+'.category').find('img').remove()

