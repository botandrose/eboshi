$ ->
  $("form:has(#clock_in)").submit (event) ->
    event.preventDefault()
    $.post this.action, $(this).serialize(), (data) ->
      $(".unbilled tbody").prepend(data)
    , "html"

  $("#content").on "click", "a.clock_out", (event) ->
    event.preventDefault()
    $.get this.href, (data) =>
      $(this).parents("tbody").find("tr#totals td.total").text(number_to_currency(data.total))
      $(this).parents("tr").replaceWith(data.work)
    , "json"

  $("#content").on "click", "a.mini_invoice_show_details", (event) ->
    event.preventDefault()
    $.get this.href, (data) =>
      $(this).parents("div:first").replaceWith(data)
    , "html"

  $("#content").on "click", "a.invoice_hide_details", (event) ->
    event.preventDefault()
    $.get this.href, (data) =>
      $(this).parents("table:first").replaceWith(data)
    , "html"

