$(document).ready ->
  $('.select-image .image').click ->
    if $(this).hasClass('upload')
      $(this).removeClass('upload')
      $(this).parent().find('.category-select').removeClass('show')
    else
      $(this).addClass('upload')
      $(this).parent().find('.category-select').addClass('show')

  $('.category-select option').click ->
    category = $(this).text()

    $(this).closest('.select-image').clone().appendTo('.category.'+category)
