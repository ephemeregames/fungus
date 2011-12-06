# Array Remove - By John Resig (MIT Licensed)
# Translated in CoffeeScript by Jodi Giordano
Array::removeAt = (from, to) ->
  rest = this.slice((to || from) + 1 || this.length)
  this.length = from < 0 ? this.length + from : from
  this.push.apply this rest

Array::clear = ->
  this.length = 0

