describe "EntityManager", ->
  type = "SomeType"

  beforeEach ->
    @repository = {}
    @repository[type] = {}
    @entities = new EntityManager(@repository)

  describe "#create()", ->
    it "initializes the new entity with the passed-in function", ->
      pool =
        create: -> { someValue: 1 }
      @repository[type] = { SomeComponent: pool }

      a = @entities.create type, (info) ->
        info["SomeComponent"].someValue += 1
      b = @entities.create(type, (info) ->)

      expect(@entities[a]["SomeComponent"].someValue).to.equal(2)
      expect(@entities[b]["SomeComponent"].someValue).to.equal(1)

    it "creates new entities when there are none to be reused", ->
      a = @entities.create(type)
      b = @entities.create(type)
      expect(a).not.to.equal(b)

    it "re-uses entities", ->
      a = @entities.create(type)
      @entities.release(a)
      b = @entities.create(type)
      expect(a).to.equal(b)

    it "throws an error when creating an unknown entity type", ->
      expect(=> @entities.create()).to.throw(/unknown entity type/)

    it "creates components on entity creation", ->
      pool =
        create: (->)
      @repository[type] = { position: pool }

      mock = sinon.mock(pool)
      mock.expects("create").twice().withExactArgs().on(pool)

      a = @entities.create(type)
      b = @entities.create(type)

      mock.verify()

    it "releases components on entity release", ->
      objA = { A: "" }
      objB = { B: "" }
      objs = [objB, objA]
      pool = create: (-> objs.pop()), release: (->)
      @repository[type] = { position: pool }

      a = @entities.create(type)
      b = @entities.create(type)
      mock = sinon.mock(pool)
      mockA = mock.expects("release").withExactArgs(objA).on(pool)
      mockB = mock.expects("release").withExactArgs(objB).on(pool)

      @entities.release(a)
      @entities.release(b)

      mock.verify()
      sinon.assert.callOrder(mockA, mockB)

    it "allows lookup of entities", ->
      position = {}
      pool = create: (-> position), release: (->)
      @repository[type] = { position: pool }

      a = @entities.create(type)
      expect(@entities[a].position).to.equal(position)
      @entities.release(a)
      expect(@entities[a]).to.equal(null)

  describe "#withComponents", ->
    it "finds all entities containing all specified components", ->
      pool = create: ->

      @repository["A"] = { SoComponent: pool }
      @repository["B"] = { SoComponent: pool, SuchComponent: pool }
      @repository["C"] = { SoComponent: pool, SuchComponent: pool, AmazeComponent: pool }
      @repository["D"] = { SuchComponent: pool, AmazeComponent: pool }
      @repository["E"] = { AmazeComponent: pool }

      a = @entities.create("A")
      b = @entities.create("B")
      c = @entities.create("C")
      d = @entities.create("D")
      e = @entities.create("E")

      expect(@entities.withComponents("SoComponent", "SuchComponent")).to.have.keys(b.toString(), c.toString())
      expect(@entities.withComponents("SoComponent")).to.have.keys(a.toString(), b.toString(), c.toString())
      expect(@entities.withComponents("SoComponent", "SuchComponent", "AmazeComponent")).to.have.keys(c.toString())
