$(document).ready ->
  $("input.date").pickadate
    format: 'dd/mm/yyyy'
  $("input.time").pickatime
    format: 'HH:i'
    formatSubmit: 'HH:i'
