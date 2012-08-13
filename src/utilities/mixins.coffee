class @Module

  @moduleKeywords = ['extended', 'included']

  # Add class properties from the class 'from' to the class 'to'
  @extend: (from, to) =>
    for key, value of from when key not in @moduleKeywords
      to[key] = value

    from.extended?.apply(to)


  # Add instance properties from the class 'from' to the class 'to'
  @include: (from, to) =>
    for key, value of from.prototype when key not in @moduleKeywords
      to::[key] = value

    included = from.included
    included.apply(to) if included
    to

