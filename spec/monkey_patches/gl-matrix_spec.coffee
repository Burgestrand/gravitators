describe "gl-matrix", ->
  describe "vec2", ->
    specify ".fromValue creates a vec2 with x and y as given value", ->
      v = vec2.fromValue(10)
      expect(v[0]).to.equal(10)
      expect(v[1]).to.equal(10)

    specify ".polar assigns an existing vector to an angle and length", ->
      v = vec2.create()

      vec2.polar(v, Math.PI / 2, 1)
      expect(v[0]).to.be.closeTo(0, 0.001)
      expect(v[1]).to.be.closeTo(1, 0.001)

      vec2.polar(v, Math.PI, 3)
      expect(v[0]).to.be.closeTo(-3, 0.001)
      expect(v[1]).to.be.closeTo(0, 0.001)

      vec2.polar(v, -Math.PI, 8)
      expect(v[0]).to.be.closeTo(-8, 0.001)
      expect(v[1]).to.be.closeTo(0, 0.001)

      vec2.polar(v, Math.PI / 4, 4)
      expect(v[0]).to.be.closeTo(2.82, 0.01)
      expect(v[1]).to.be.closeTo(2.82, 0.01)
      expect(vec2.length(v)).to.be.closeTo(4, 0.01)

    specify ".clear sets a vector to 0", ->
      v = vec2.fromValues(3, 7)
      vec2.clear(v)
      expect(v[0]).to.equal(0)
      expect(v[1]).to.equal(0)
