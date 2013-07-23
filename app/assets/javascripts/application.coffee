# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require pusher
#= require_tree .

window.location.hash = ""  if window.location.hash is "#_=_"


  #this assumes the action returns an HTML snippet

$(document).ready ->

  $('#pusher-comment .icon-remove').click ->
    $(this).parent().hide()
  $('#pusher-comment').on "click",'.comment', ->
    image_id = $(this).attr('name')
    window.location = '/images/'+image_id
  Pusher.host = '127.0.0.1'
  Pusher.ws_port = 8080
  Pusher.wss_port = 8080

  pusher = new Pusher('1c81fd8f32b04884c7ac10a7df682973', { encrypted: false })
  channel = pusher.subscribe('comment-channel')

  channel.bind "comment-event",  (response)->
    date = new Date(response.comment['created_at'])
    user_name = response.user
    image_id = response.comment['image_id']
    $('#pusher-comment').show()
    $('#pusher-comment .pusher-content').append('<div class="comment" name="'+image_id+'"><span class = "author"><small>Comment by</small> '+user_name+' </span><span class = "time-send">'+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds()+'</span><span class = "body">'+response.comment['body']+'</span></div>')

  $("form#new_comment").bind("ajax:success", (evt, data, status, xhr) ->
     $('#comments h3').append('<div class="comment-block"><img src="'+data.responseJSON.image+'"class="avatar" alt="Avatar"><div class="comment-info"><span class="comment-user"> Comment by '+data.responseJSON.author+' </span> <span class="comment-date"> Date '+data.responseJSON.date+' </span> </div> <div class="comment"> '+data.responseJSON.comment+'</div></div>')
     $('#comment_body').val('')
  ).bind "ajax:error", (evt, data, status, xhr) ->
     $('#comments h3').after('<div class="comment-block"><img src="'+data.responseJSON.image+'"class="avatar" alt="Avatar"><div class="comment-info"><span class="comment-user"> Comment by '+data.responseJSON.author+' </span> <span class="comment-date"> Date '+data.responseJSON.date+' </span> </div> <div class="comment"> '+data.responseJSON.comment+'</div></div>')
     $('#comment_body').val('')
#  $('#live-chat .img-button').click ->
#    $('.chat-block').animate
#      width: "10%"
#      , 1000, ->
#      width: "100%"


