$(document).ready ->
  $('textarea').autosize()
  $(".editable").restInPlace()
  $('.editable').bind 'ready.rest-in-place', ->
    $('textarea').autosize()
  $('.editable').bind 'update.rest-in-place', ->
    $(@).hide()
    $(@).after('<span class="saving">salvando...</span>')
  $('.editable').bind 'success.rest-in-place failure.rest-in-place', ->
    $('.saving').remove()
    $(@).show()
  $("input.date").pickadate
    format: 'dd/mm/yyyy'
  $("input.time").pickatime
    format: 'HH:i'
    formatSubmit: 'HH:i'
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
