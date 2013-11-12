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
        $.post $(this).attr("data-url"), '_method=put&line_item[notes]='+escape(this.value)
        this.wait = true

    this.delayedSend()

