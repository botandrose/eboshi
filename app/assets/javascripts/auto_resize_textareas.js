//= require jquery.livequery

$(window).load(function () {
  $("td.notes textarea").livequery(function() {
    new AutoResizeTextArea.init(this)
  })
})

var AutoResizeTextArea = {
  init: function(el) {
    // get height of the element; use as minimum
    var originalHeight = el.offsetHeight;  
      
    // adjust the textarea, for all good browsers: overflow:hidden to lose the scrollbars,   
    // for IE use overflowX:auto to let that browser decide whether to show scrollbars  
    $(el).css("overflow", "hidden")
    $(el).css("overflowX", "auto")
      
    // create a new element that will be used to track the dimensions  
    var dummy = document.createElement('pre');  
    el.parentNode.appendChild(dummy);
  
    // hide the created div away  
    $(dummy).css({ position: 'absolute', left: "-99999px", "white-space": "pre-wrap" })
    $(dummy).addClass("dummy")
    var width = $(el).innerWidth()
    $(dummy).css('width', width)

    dummy.innerHTML = 'a';
    var lineHeight = dummy.offsetHeight;  

    var checkExpandContract = function() {
      // place text inside the element in a new var called html  
      // transfer content to dummy      
      dummy.innerHTML = el.value;
          
      // ensure minimum height
      if (dummy.offsetHeight < originalHeight) {
        height = originalHeight;
      } else {
        height = dummy.offsetHeight + lineHeight;
      }
      $(el).css({ height: height });
    }
    
    // Put eventListeners to our elements
    $(el).keyup(checkExpandContract);
    checkExpandContract();
  }
}
