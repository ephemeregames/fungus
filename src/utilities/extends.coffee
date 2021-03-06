# Array Remove - By John Resig (MIT Licensed)
# Translated in CoffeeScript by Jodi Giordano
Array::removeAt = (from, to) ->
  rest = this.slice((to || from) + 1 || this.length)
  this.length = from < 0 ? this.length + from : from
  this.push.apply this rest

Array::clear = ->
  this.length = 0


# From http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen
# Translated in CoffeeScript by Jodi Giordano
jQuery.fn.center = ->
  this.css('position', 'absolute')
  this.css('top', ((jQuery(window).height() - this.outerHeight()) / 2) + jQuery(window).scrollTop() + 'px')
  this.css('left', ((jQuery(window).width() - this.outerWidth()) / 2) + jQuery(window).scrollLeft() + 'px')
  
  return this


# From http://stackoverflow.com/questions/280634/endswith-in-javascript
# Translated in CoffeeScript by Jodi Giordano
String::endsWith = (suffix) ->
  return this.indexOf(suffix, this.length - suffix.length) isnt -1

