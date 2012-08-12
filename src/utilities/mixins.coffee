class @Module

  @moduleKeywords = ['extended', 'included']

  @extend: (from, to) =>
    for key, value of from when key not in @moduleKeywords
      to[key] = value

    from.extended?.apply(to)


  @include: (from, to) =>
    for key, value of from when key not in @moduleKeywords
      to::[key] = value

    from.included?.apply(to)
