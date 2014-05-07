$(document).ready ->
  $('.timestamp').datetimepicker
    language: 'pt-br'
    defaultDate: "24/7/13"
    useSeconds: false
  $(".open").on "click", (event) ->
    event.preventDefault()
    event.stopPropagation()
    $(@).parent().find("nav").toggle()
  $("input").click (event) ->
    event.stopPropagation()
  setTimeout (->
    $('#flash').slideDown('slow')
  ), 100
  setTimeout (->
    $('#flash').slideUp('slow')
  ), 16000
  $(window).on "click", ->
    $('#flash').slideUp('slow')
    $('.open').parent().find("nav").hide()
