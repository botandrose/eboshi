document.observe('dom:loaded', function() {
  $$('input[type=submit].delete').each(function(b) {
    b.onclick = null
    b.observe('click', function(e) {
      e.stop()
      if(confirm('Are you sure?')) {
        new Ajax.Request(b.form.action, {
          parameters: b.form.serialize(),
          onComplete: function(response) {
            eval('total = '+response.responseText);
            b.up('tbody').down('td.total').innerHTML = number_to_currency(total)
            b.up('tr').remove()
          }
        })
      }
    })
  })
  
  $('clock_in').observe('click', function(e) {
    e.stop()
    new Ajax.Updater('new_line_items', this.form.action, {
      parameters: this.form.serialize(),
      insertion: 'after',
      onComplete: clock_out_links
    })
  })
  
  $$('a.merge').each(function(a) {
    a.observe('click', function(e) {
      e.stop()
      var checkboxes = $$('input:checked')
      var first = checkboxes.first()
      var others = checkboxes.reject(function(cb) { return cb.value == first.value })
      new Ajax.Request(a.href+'?'+Form.serializeElements(checkboxes), { onComplete: function(response) {
        first.up('tr').replace(response.responseText)
        others.each(function(cb) { cb.up('tr').remove() })
      }})
    })
  })
  
  $('show_paid_invoices').observe('click', function(e) {
    e.stop()
    var el = $('paid_invoices')
    if(el.cleanWhitespace().innerHTML == '') {
      el.hide()
      new Ajax.Updater(el, $('show_paid_invoices').href, { method: 'get', onComplete: function() {
        ajax_mini_invoice_show_links()
        new Effect.BlindDown(el)
      }})
    } else {
      if(el.style.display == 'none') new Effect.BlindDown(el)
      else new Effect.BlindUp(el)
    }
  })
  
  ajax_mini_invoice_show_links()
  clock_out_links()
})

function ajax_mini_invoice_show_links() {
  $$('.mini_invoice_show_details').each(function(a) {
    a.observe('click', function(e) {
      e.stop()
      new Ajax.Request(a.href, { method: 'get', onComplete: function(response) {
        a.up('div').replace(response.responseText)
      }})
    })
  })
}

function clock_out_links() {
  $$('.clock_out').each(function(a) {
    a.observe('click', function(e) {
      e.stop()
      new Ajax.Request(a.href, {
        onComplete: function(response) {
          eval('object = '+response.responseText);
          a.up('tr').replace(object.line_item)
          b.up('tbody').down('td.total').innerHTML = number_to_currency(object.total)
        }
      })
    })
  })
}
