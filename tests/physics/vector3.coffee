fungus = require './physics/vector3'
assert = require 'assert'

# Create an empty vector
v = new fungus.Vector3()

assert.equal(0, v.x)
assert.equal(0, v.y)
assert.equal(0, v.z)

# Operators
v1 = fungus.Vector3.Side()    # (-1.0, 0.0, 0.0)
v2 = fungus.Vector3.Up()      # (0.0, 1.0, 0.0)
v3 = fungus.Vector3.Forward() # (0.0, 0.0, 1.0)
v4 = fungus.Vector3.Unit()    # (1.0, 1.0, 1.0)
v5 = new fungus.Vector3(1, 2, 3)
v6 = new fungus.Vector3(4, 5, 6)

assert.ok(v1.plus(v2).equals(new fungus.Vector3(-1, 1, 0)))
assert.ok(v1.plus(v2).differs(new fungus.Vector3(0, 0, 0)))
assert.ok(v1.minus(v2).equals(new fungus.Vector3(-1, -1, 0)))
assert.ok(v1.unaryMinus().equals(new fungus.Vector3(1, 0, 0)))
assert.ok(v5.multiply(v6).equals(new fungus.Vector3(4, 10, 18)))
assert.ok(v5.scalarProduct(v6).equals(new fungus.Vector3(4, 10, 18)))
assert.ok(v6.divide(v5).equals(new fungus.Vector3(4, 2.5, 2)))
assert.equal(32, v5.dot(v6))
assert.equal(1, v1.length())
assert.equal(1, v2.length())
assert.equal(1, v3.length())
assert.equal(14, v5.lengthSquared())
assert.ok(v1.normalize().equals(new fungus.Vector3(-1, 0, 0)))
assert.ok(v2.normalize().equals(new fungus.Vector3(0, 1, 0)))
assert.ok(v3.normalize().equals(new fungus.Vector3(0, 0, 1)))
assert.ok(v1.cross(v1).equals(new fungus.Vector3(0, 0, 0)))
assert.ok(v5.cross(v6).equals(new fungus.Vector3(-3, 6, -3)))
