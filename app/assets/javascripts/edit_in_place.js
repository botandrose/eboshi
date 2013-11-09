$(function() {
  $("#content").on("keyup", "td.notes textarea", function() {
    this.url = $(this).attr("data-url")
    this.buffer = this.value
    this.wait = false
    // grab line_item id from tr
    this.line_item_id = this.id.match(/notes_([0-9]+)/)[1]

    // ignore non destructive keypresses
    if(this.buffer == this.value) return
    
    // send updates out every two seconds
    if(this.wait) {
      window.setTimeout('\
        $("textarea#notes_'+this.line_item_id+'")[0].wait = false;\
        $("textarea#notes_'+this.line_item_id+'")[0].delayedSend();\
      ', 500)
    } else {
      this.buffer = this.value
      $.post(this.url, '_method=put&line_item[notes]='+escape(this.value))
      this.wait = true
    }
  });
});
