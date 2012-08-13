class @Vector3

  constructor: ->
    switch arguments.length
      when 0
        @x = 0.0
        @y = 0.0
        @z = 0.0
      when 1
        @x = arguments[0].x * 1.0 # ensure float
        @y = arguments[0].y * 1.0
        @z = arguments[0].z * 1.0
      when 3
        @x = arguments[0] * 1.0
        @y = arguments[1] * 1.0
        @z = arguments[2] * 1.0


  plus: (other) =>
    return new Vector3(@x + other.x, @y + other.y, @z + other.z) if other instanceof Vector3
    new Vector3(@x + other, @y + other, @z + other)


  plusInPlace: (other) =>
    if other instanceof Vector3
      @x += other.x
      @y += other.y
      @z += other.z
    else
      @x += other
      @y += other
      @z += other

    this


  minus: (other) =>
    return new Vector3(@x - other.x, @y - other.y, @z - other.z) if other instanceof Vector3
    new Vector3(@x - other, @y - other, @z - other)

  minusInPlace: (other) =>
    if other instanceof Vector3
      @x -= other.x
      @y -= other.y
      @z -= other.z
    else
      @x -= other
      @y -= other
      @z -= other

    this


  unaryMinus: =>
    new Vector3(-@x, -@y, -@z)


  unaryMinusInPlace: =>
    @x = -@x
    @y = -@y
    @z = -@z

    this


  multiply: (other) =>
    return new Vector3(@x * other.x, @y * other.y, @z * other.z) if other instanceof Vector3
    new Vector3(@x * other, @y * other, @z * other)


  multiplyInPlace: (other) =>
    if other instanceof Vector3
      @x *= other.x
      @y *= other.y
      @z *= other.z
    else
      @x *= other
      @y *= other
      @z *= other

    this


  scalarProduct: (other) =>
    this.multiply(other)


  scalarProductInPlace: (other) =>
    this.multiplyInPlace(other)


  divide: (other) =>
    return new Vector3(@x / other.x, @y / other.y, @z / other.z) if other instanceof Vector3
    new Vector3(@x / other, @y / other, @z / other)


  divideInPlace: (other) =>
    if other instanceof Vector3
      @x /= other.x
      @y /= other.y
      @z /= other.z
    else
      @x /= other
      @y /= other
      @z /= other

    this


  dot: (other) =>
    @x * other.x +
    @y * other.y +
    @z * other.z


  length: =>
    Math.sqrt(this.lengthSquared())


  lengthSquared: =>
    this.dot(this)


  normalize: =>
    len = this.length()

    return new Vector3(this) if len <= 0.0

    this.divide(len)


  normalizeInPlace: =>
    len = this.length()

    return this if len <= 0.0

    this.divideInPlace(len)


  cross: (other) =>
    new Vector3(
      @y * other.z - @z * other.y,
      @z * other.x - @x * other.z,
      @x * other.y - @y * other.x
    )


  crossInPlace: (other) =>
    @x = @y * other.z - @z * other.y
    @y = @z * other.x - @x * other.z
    @z = @x * other.y - @y * other.x


  set: =>
    switch arguments.length
      when 1
        if arguments[0] instanceof Vector3
          @x = arguments[0].x * 1.0
          @y = arguments[0].y * 1.0
          @z = arguments[0].z * 1.0
        else
          @x = arguments[0] * 1.0
          @y = arguments[0] * 1.0
          @z = arguments[0] * 1.0
      when 3
        @x = arguments[0] * 1.0
        @y = arguments[1] * 1.0
        @z = arguments[2] * 1.0

    this


  equals: (other) =>
    if other instanceof Vector3
      return (
        Math.abs(@x - other.x) < 0.000000001 &&
        Math.abs(@y - other.y) < 0.000000001 &&
        Math.abs(@z - other.z) < 0.000000001
      )

    Math.abs(@x - other) < 0.000000001 &&
    Math.abs(@y - other) < 0.000000001 &&
    Math.abs(@z - other) < 0.000000001


  differs: (other) =>
    !this.equals(other)


  # Return component of vector parallel to a unit basis vector
  # (IMPORTANT NOTE: assumes "basis" has unit magnitude (length == 1))
  parallelComponent: (unitBasis) =>
    projection = dot(unitBasis)
    unitBasis.scalarProduct(projection)


  # Return component of vector perpendicular to a unit basis vector
  # (IMPORTANT NOTE: assumes "basis" has unit magnitude (length == 1))
  perpendicularComponent: (unitBasis) =>
    this.minus(parallelComponent(unitBasis))


  # Clamps the length of a given vector to maxLength. If the vector is
  # shorter its value is returned unaltered, if the vector is longer
  # the value returned has length of maxLength and is parallel to the
  # original input.
  truncateLength: (maxLength) =>
    maxLengthSquared = maxLength * maxLength
    vecLengthSquared = this.lengthSquared()

    return this.scalarProduct(maxLength / Math.sqrt(vecLengthSquared)) if vecLengthSquared > maxLengthSquared

    new Vector3(this)


  truncateLengthInPlace: (maxLength) =>
    maxLengthSquared = maxLength * maxLength
    vecLengthSquared = this.lengthSquared()

    return this.scalarProductInPlace(maxLength / Math.sqrt(vecLengthSquared)) if vecLengthSquared > maxLengthSquared

    this


  # Used to force a 3D position onto a plane (aka XZ plane with y = 0)
  setYToZero: =>
    new Vector3(@x, 0.0, @z)


  setYToZeroInPlace: =>
    @y = 0.0


  # Rotate this vector about the global Y (up) axis by the given angle
  # TODO caching method, rotateAboutGlobalY: (angle, sin, cos) =>
  rotateAboutGlobalY: (angle) =>
    s = Math.sin(angle)
    c = Math.cos(angle)

    new Vector3(
      @x * c + @z * s,
      @y,
      @z * c - @x * s
    )


  rotateAboutGlobalYInPlace: (angle) =>
    s = Math.sin(angle)
    c = Math.cos(angle)

    @x = @x * c + @z * s
    @y = @y
    @z = @z * c - @x * s


  sphericalWrapAround: (center, radius) =>
    offset = this.minus(center)
    r = offset.length()

    return this.plus((offset.divideInPlace(r).multiplyInPlace(radius).multiplyInPlace(-2))) if r > radius

    new Vector3(this)


  sphericalWrapAroundInPlace: (center, radius) =>
    offset = this.minus(center)
    r = offset.length()

    return this.plusInPlace((offset.divideInPlace(r).multiplyInPlace(radius).multiplyInPlace(-2))) if r > radius

    this


  toString: =>
    "(#{@x},#{@y},#{@z})"


  @cross: (a, b) =>
    new Vector3(
      a.y * b.z - a.z * b.y,
      a.z * b.x - a.x * b.z,
      a.x * b.y - a.y * b.x
    )


  # Returns a position randomly distributed inside a sphere of unit radius
  # centered at the origin.  Orientation will be random and length will range
  # between 0 and 1
  @randomVectorInUnitRadiusSphere: =>
    v = new Vector3()

    v.set(Math.random() * 2 - 1, Math.random() * 2 - 1, Math.random() * 2 - 1) while v.length() >= 1
    v


  # Returns a position randomly distributed on a disk of unit radius
  # on the XZ (Y=0) plane, centered at the origin.  Orientation will be
  # random and length will range between 0 and 1
  @randomVectorOnUnitRadiusXZDisk: =>
    v = new Vector3()
    v.set(Math.random() * 2 - 1, 0, Math.random() * 2 - 1) while v.length() >= 1
    v


  # Returns a position randomly distributed on the surface of a sphere
  # of unit radius centered at the origin.  Orientation will be random
  # and length will be 1
  @randomUnitVector: =>
    Vector3.randomVectorInUnitRadiusSphere().normalize()


  # Returns a position randomly distributed on a circle of unit radius
  # on the XZ (Y=0) plane, centered at the origin.  Orientation will be
  # random and length will be 1
  @RandomUnitVectorOnXZPlane: =>
    Vector3.randomVectorInUnitRadiusSphere().setYtoZero().normalize()


  # Does a "ceiling" or "floor" operation on the angle by which a given vector
  # deviates from a given reference basis vector.  Consider a cone with "basis"
  # as its axis and slope of "cosineOfConeAngle".  The first argument controls
  # whether the "source" vector is forced to remain inside or outside of this
  # cone.  Called by vecLimitMaxDeviationAngle and vecLimitMinDeviationAngle.
  @vecLimitDeviationAngleUtility: (insideOrOutside, source, cosineOfConeAngle, basis) =>
    sourceLength = source.length()

    # immediately return zero length input vectors
    return source if sourceLength == 0

    # measure the angular diviation of "source" from "basis"
    direction = source.divide(sourceLength)
    cosineOfSourceAngle = direction.dot(basis)

    # simply return "source" if it already meets the angle criteria.
    return source if insideOrOutside && cosineOfSourceAngle >= cosineOfConeAngle
    return source if cosineOfSourceAngle <= cosineOfConeAngle

    # find the portion of "source" that is perpendicular to "basis" and normalize it
    unitPerp = source.perpendicularComponent(basis).normalizeInPlace()

    # construct a new vector whose length equals the source vector,
    # and lies on the intersection of a plane (formed the source and
    # basis vectors) and a cone (whose axis is "basis" and whose
    # angle corresponds to cosineOfConeAngle)
    perpDist = Math.sqrt(1 - (cosineOfConeAngle * cosineOfConeAngle))
    c0 = basis.multiply(cosineOfConeAngle)
    c1 = unitPerp.multiply(perpDist)

    c0.plus(c1).multiplyInPlace(sourceLength)


  # Enforce an upper bound on the angle by which a given arbitrary vector
  # diviates from a given reference direction (specified by a unit basis
  # vector).  The effect is to clip the "source" vector to be inside a cone
  # defined by the basis and an angle.
  @limitMaxDeviationAngle: (source, cosineOfConeAngle, basis) =>
    Vector3.vecLimitDeviationAngleUtility(true, source, cosineOfConeAngle, basis)


  # Enforce a lower bound on the angle by which a given arbitrary vector
  # diviates from a given reference direction (specified by a unit basis
  # vector).  The effect is to clip the "source" vector to be outside a cone
  # defined by the basis and an angle.
  @limitMinDeviationAngle: (source, cosineOfConeAngle, basis) =>
    vecLimitDeviationAngleUtility(false, source, cosineOfConeAngle, basis)


  # Returns the distance between a point and a line.  The line is defined in
  # terms of a point on the line ("lineOrigin") and a UNIT vector parallel to
  # the line ("lineUnitTangent")
  @distanceFromLine: (point, lineOrigin, lineUnitTangent) =>
    offset = point.minus(lineOrigin)
    perp = offset.perpendicularComponent(lineUnitTangent)
    perp.length()


  # Given a vector, return a vector perpendicular to it (note that this
  # arbitrarily selects one of the infinitude of perpendicular vectors)
  @findPerpendicularIn3d: (direction) =>
    # three mutually perpendicular basis vectors
    i = new Vector3(1, 0, 0)
    j = new Vector3(0, 1, 0)
    k = new Vector3(0, 0, 1)

    # measure the projection of "direction" onto each of the axes
    id = i.dot(direction)
    jd = j.dot(direction)
    kd = k.dot(direction)

    if id <= jd && id <= kd
      quasiPerp = i
    else if jd <= id && jd <= kd
      quasiPerp = j
    else
      quasiPerp = k

    # return the cross product (direction x quasiPerp)
    # which is guaranteed to be perpendicular to both of them
    Vector3.cross(direction, quasiPerp)


  # Returns the nearest point on the segment @a segmentPoint0 to
  # @a segmentPoint1 from @a point.
  @nearestPointOnSegment: (point, segmentPoint0, segmentPoint1) =>
    local = point.minus(segmentPoint0)

    segment = segmentPoint1.minus(segmentPoint0)
    segmentLength = segment.length()
    segmentNormalized = segment.normalize()
    segmentProjection = segmentNormalized.dot(local)
    segmentProjection.truncateLengthInPlace()

    result = segmentNormalized.scalarProduct(segmentProjection)
    result.addInPlace(segmentPoint0)
    result


  # Computes minimum distance from @a point to the line segment defined by
  # @a segmentPoint0 and @a segmentPoint1.
  @pointToSegmentDistance: (point, segmentPoint0, segmentPoint1) =>
    distance(point, nearestPointOnSegment(point, segmentPoint0, segmentPoint1))


  # Returns distance between @a a and @a b.
  @distance: (a, b) =>
    a.minus(b).length()


  # Constants
  @Zero:    => new Vector3(0.0, 0.0, 0.0)
  @Side:    => new Vector3(-1.0, 0.0, 0.0)
  @Up:      => new Vector3(0.0, 1.0, 0.0)
  @Forward: => new Vector3(0.0, 0.0, 1.0)
  @Unit:    => new Vector3(1.0, 1.0, 1.0)
