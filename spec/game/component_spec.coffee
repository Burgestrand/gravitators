describe "Component", ->
  beforeEach ->
    class @Whatever extends Component

  describe ".pool()", ->
    it "returns the same pool for the same class", ->
      a = Component.pool()
      b = Component.pool()
      expect(a).to.equal(b)

    it "returns a different pool for subclasses", ->
      a = Component.pool()
      b = @Whatever.pool()
      c = @Whatever.pool()
      expect(a).not.to.equal(b)
      expect(b).to.equal(c)

  describe ".create()", ->
    it "creates a new object if the pool has no free objects", ->
      a = @Whatever.create()
      b = @Whatever.create()
      expect(a).not.to.equal(b)

    it "reuses old objects if the pool has free objects", ->
      a = @Whatever.create()
      @Whatever.release(a)
      b = @Whatever.create()
      expect(a).to.equal(b)

    it "uses the constructor as initializer", ->
      count = 0
      class Whatelse extends Component
        constructor: ->
          count += 1

      a = Whatelse.create()
      expect(count).to.equal(1)
      b = Whatelse.create()
      expect(count).to.equal(2)
      Whatelse.release(a)

      c = Whatelse.create()
      expect(count).to.equal(3)
      expect(a).to.equal(c)

    it "passes in passed arguments to the constructor", ->
      class Whatelse extends Component
        constructor: (@x, @y) ->

      a = Whatelse.create(2, 7)
      expect(a.x).to.equal(2)
      expect(a.y).to.equal(7)
      Whatelse.release(a)

      b = Whatelse.create(11, 9)
      expect(b.x).to.equal(11)
      expect(b.y).to.equal(9)
      expect(a).to.equal(b)

  describe ".release()", ->
    it "calls deallocate", ->
      class Whatelse extends Component
        deallocate: ->
          @finished = true

      a = Whatelse.create()
      expect(a.finished).to.be.undefined
      Whatelse.release(a)
      expect(a.finished).to.be.true
