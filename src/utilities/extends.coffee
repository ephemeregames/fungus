# Array Remove - By John Resig (MIT Licensed)
# Translated in CoffeeScript by Jodi Giordano
Array::removeAt = (from, to) ->
  rest = this.slice((to || from) + 1 || this.length)
  this.length = from < 0 ? this.length + from : from
  this.push.apply this rest

Array::clear = ->
  this.length = 0

# From http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen
jQuery.fn.center = ->
  this.css('position', 'absolute')
  this.css('top', (($(window).height() - this.outerHeight()) / 2) + $(window).scrollTop() + 'px')
  this.css('left', (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + 'px')
  
  return this
