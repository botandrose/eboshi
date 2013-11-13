$ ->
  $("#content").on "keyup", "td.notes textarea", ->
    this.delayedSend = ->
      # ignore non destructive keypresses
      return if this.buffer == this.value
      
      # send updates out every two seconds
      if this.wait
        self = this
        window.setTimeout ->
          self.wait = false
          self.delayedSend()
        , 500

      else
        this.buffer = this.value
        data =
          "_method": "put"
          "line_item[notes]": this.value
          "line_item[timestamp]": new Date().getTime()
        $.post $(this).attr("data-url"), data
        this.wait = true

    this.delayedSend()

