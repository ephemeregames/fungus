class @Identifiable

  @NextID = 0


  constructor: ->
    @id = ++Identifiable.NextID
