send_image = new Array()
category_id = 0
$(document).ready ->
  $(".select-category").click (event) ->
    $(event.currentTarget).parent().find(".category-select-list").fadeToggle('slow')
  $('.category-select-name').click (event) ->
    $(event.currentTarget).parent().hide()
    text = $(event.currentTarget).text()
    $(event.currentTarget).closest('.select-image').find('.select-category').text(text)
    category = $.trim($(event.currentTarget).text())
    title = $(event.currentTarget).closest('.select-image').find('.title-image').val()
    image = $(event.currentTarget).closest('.select-image').find('img').clone().attr({'alt': title})
    $('.categories-parse.'+category+' h3').after(image)
    $(event.currentTarget).closest('.select-image').remove()

  $('.categories-parse').on "click", "img", ->
    $(this).remove()


  $('.categories-parse .send-images').on "click", ->
    send_image=[]
    category_id = $(this).parent().attr('id')
    $(this).parent().find('img').each (index, val) ->
      send_image[index] = [val.src, val.alt]

    $.ajax(
      url: "/admin/parse/save_img"
      data:
        send_image: send_image
        category_id: category_id
      dataType: "json"
      type: "POST"
    ).success (response) ->
      $('#'+category_id+'.categories-parse').find('img').remove()

