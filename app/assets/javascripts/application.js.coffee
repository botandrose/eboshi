#= require jquery
#= require jquery_ujs
#= require invoices
#= require new_invoice

# Checkbox toggle

jQuery.fn.toggleChecks = (bool) ->
  return false unless $(this).is(":checkbox")
  $(this).attr "checked", !$(this).attr("checked")

# jQuery extensions

jQuery.ajaxSetup
  beforeSend: (xhr) -> xhr.setRequestHeader("Accept", "text/javascript")

# Misc

Date.prototype.toSQL = ->
  this.getFullYear() + '-' +
    (this.getMonth() + 1).toPaddedString(2) + '-' +
    this.getDate().toPaddedString(2) + ' ' +
    this.getHours().toPaddedString(2) + ':' +
    this.getMinutes().toPaddedString(2) + ':' +
    this.getSeconds().toPaddedString(2)

window.number_to_currency = (number, options) ->
  try
    options   = options || {}
    precision = options.precision || 2
    unit      = options.unit || "$"
    separator = if precision > 0 then options.separator || "." else ""
    delimiter = options.delimiter || ","
 
    parts = parseFloat(number).toFixed(precision).split('.')
    unit + number_with_delimiter(parts[0], delimiter) + separator + parts[1].toString()

  catch e
    number

window.number_with_delimiter = (number, delimiter, separator) ->
  try
    delimiter = delimiter || ","
    separator = separator || "."
    
    parts = number.toString().split('.')
    parts[0] = parts[0].replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1" + delimiter)
    parts.join(separator)

  catch e
    number

