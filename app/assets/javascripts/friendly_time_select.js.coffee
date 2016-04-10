$ ->
  $("[id$=_4i] option").each ->
    number = parseInt($(this).text(), 10)
    if number == 0
      number = "12 am"
    else if number == 12
      number = "12 pm"
    else if number > 12
      number = (number - 12) + " pm"
    else
      number += " am"

    $(this).text(number)

