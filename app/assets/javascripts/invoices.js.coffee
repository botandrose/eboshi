#= require edit_in_place

$ ->
  $("#content").on "mouseover", "tr.line_item", ->
    $(this).addClass("line_item_over")

  $("#content").on "mouseout", "tr.line_item", ->
    $(this).removeClass("line_item_over")

  $("#content").on "click", "tr.line_item", (e) ->
    return if e.target.type == 'textarea'
    $(this).toggleClass("line_item_selected")
    if !$(e.target).is(":checkbox")
      $(this).find(":checkbox").toggleChecks()
  
  $("a#create_invoice").click (event) ->
    event.preventDefault()
    line_items = $("input:checked").serialize()
    location.href = this.href+"?"+line_items

  $("#content").on "click", "tr.line_item a.delete", (event) ->
    event.preventDefault()
    if confirm('Are you sure you want to delete this line item? This cannot be undone!')
      $.post @href, '_method=delete', (data) =>
        $(this).parents("tbody").find("tr#totals td.total").text(number_to_currency(data))
        $(this).parents("tr").remove()
      , 'json'
  
  $("a#merge").click (event) ->
    event.preventDefault()
    checkboxes = $(".line_item input:checked")
    if checkboxes.length > 0
      $.post this.href, checkboxes.serialize(), (data) ->
        $(checkboxes[0]).parents("tr").replaceWith(data)
        checkboxes.slice(1).parents("tr").remove()
      , "text"

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

