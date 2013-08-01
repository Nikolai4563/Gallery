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
    $(this).closest('.select-image').find('img').clone().appendTo('.categories.'+category)
    $(this).closest('.select-image').remove()

  $('.categories').on "click", "img", ->
    $(this).remove()


  $('.categories .send-images').on "click", ->
    send_image=[]
    category_id = $(this).parent().attr('id')
    $(this).parent().find('img').each (index, val) ->
      send_image[index] = val.src

    $.ajax(
      url: "/admin/parse/save_img"

      data:
        send_image: send_image
        category_id: category_id
      dataType: "json"
      type: "POST"
    ).success (response) ->
      $('#'+category_id+'.categories').find('img').remove()

