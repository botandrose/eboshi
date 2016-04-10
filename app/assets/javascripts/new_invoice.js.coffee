#= require friendly_time_select

$ ->
  $("table input:checkbox").click ->
    total = 0.0
    $("table input:checked").each ->
      total += parseFloat($(this).closest("tr").find("td[data-total]").attr("data-total"))

    $("#invoice_total").val(total)

