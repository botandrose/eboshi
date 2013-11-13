$ ->
  $("form:has(#clock_in)").submit (event) ->
    event.preventDefault()
    $.post this.action, $(this).serialize(), (data) ->
      $(".unbilled tbody").prepend(data)
    , "html"

