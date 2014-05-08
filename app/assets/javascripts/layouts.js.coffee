$(document).ready ->
  $('textarea').autosize()
  $(".editable").restInPlace()
  $('.editable').bind 'ready.rest-in-place', ->
    $('textarea').autosize()
  $('.editable').bind 'update.rest-in-place', ->
    $(@).hide()
    if $(@).attr('type') == 'checkbox'
      $(@).next().hide()
    $(@).after('<span class="saving">salvando...</span><div class="saving_break">&nbsp;</div>')
  $('.editable').bind 'success.rest-in-place failure.rest-in-place abort.rest-in-place', ->
    $('.saving').remove()
    $('.saving_break').remove()
    $(@).show()
    if $(@).attr('type') == 'checkbox'
      $(@).next().show()
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
