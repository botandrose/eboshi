//= require_self
//= require edit_in_place
//= require invoices_coffee

$(function() {
  $("#content").on("mouseover", "tr.line_item", function() {
    $(this).addClass("line_item_over");
  });

  $("#content").on("mouseout", "tr.line_item", function() {
    $(this).removeClass("line_item_over");
  });

  $("#content").on("click", "tr.line_item", function(e) {
    if(e.target.type == 'textarea') return;
    $(this).toggleClass("line_item_selected");
    if(!$(e.target).is(":checkbox")) $(this).find(":checkbox").toggleChecks();
  });
  
  $("a#create_invoice").click(function() {
    var line_items = $("input:checked").serialize();
    location.href = this.href+"?"+line_items;
    return false;
  });

  $("tr.line_item a.clock_out").submit(function() {
    $.post(this.action. this.seralize()).success(function(data) {
      this.parents("tbody").find("tr#totals td.total").text(number_to_currency(data.total));
      this.parents("tr").replaceWith(data.work);
    });
  });

  $("#content").on("click", "tr.line_item a.delete", function() {
    var a = this;
    if(confirm('Are you sure you want to delete this line item? This cannot be undone!')) {
      $.post(a.href, '_method=delete', function(data) {
        $(a).parents("tbody").find("tr#totals td.total").text(number_to_currency(data));
        $(a).parents("tr").remove();
      }, 'json');
    }
    return false;
  });
  
  $("a#merge").click(function() {
    var checkboxes = $(".line_item input:checked");
    if(checkboxes.length > 0) {
      $.post(this.href, checkboxes.serialize(), function(data) {
        $(checkboxes[0]).parents("tr").replaceWith(data);
        checkboxes.slice(1).parents("tr").remove();
      }, "text");
    }
    return false;
  });

  $("a.mini_invoice_show_details").click(function() {
    $.get(this.href).success(function(data) {
      this.parents("div:first").replaceWith(data);
    });
  });

  $("a.invoice_hide_details").click(function() {
    $.get(this.href).success(function(data) {
      this.parents("table:first").replaceWith(data);
    });
  });
});
