describe "EntityManager", ->
  type = "SomeType"

  beforeEach ->
    count = 0
    class SomeComponent extends Component
      constructor: ->
        @unique = count++
        @thisIsAComponent = true
    @repository = {}
    @repository[type] = [SomeComponent]
    @entities = new EntityManager(@repository)

  describe "#create()", ->
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

    it "creates new components when there are none to be reused", ->
      a = @entities.create(type)
      ai = @entities[a]
      b = @entities.create(type)
      bi = @entities[b]
      expect(ai).not.to.equal(bi)
      expect(ai["SomeComponent"]).to.be.ok
      expect(bi["SomeComponent"]).to.be.ok
      expect(ai["SomeComponent"]).not.to.equal(bi["SomeComponent"])

    it "re-uses components", ->
      a = @entities.create(type)
      ai = @entities[a]
      aic = ai["SomeComponent"]
      expect(aic.thisIsAComponent).to.equal(true)
      aic.thisIsAComponent = false
      expect(aic.thisIsAComponent).to.equal(false)

      @entities.release(a)

      b = @entities.create(type)
      bi = @entities[b]
      bic = bi["SomeComponent"]
      expect(bic.thisIsAComponent).to.equal(true)

      expect(a).to.equal(b)
      expect(ai).to.equal(bi)
      expect(aic).to.equal(bic)

    it "allows lookup of entities", ->
      a = @entities.create(type)
      expect(@entities[a]["SomeComponent"].thisIsAComponent).to.equal(true)

  describe "#withComponents", ->
    it "finds all entities containing all specified components", ->
      class SoComponent extends Component
      class SuchComponent extends Component
      class AmazeComponent extends Component

      @repository["A"] = [SoComponent]
      @repository["B"] = [SoComponent, SuchComponent]
      @repository["C"] = [SoComponent, SuchComponent, AmazeComponent]
      @repository["D"] = [SuchComponent, AmazeComponent]
      @repository["E"] = [AmazeComponent]

      a = @entities.create("A")
      b = @entities.create("B")
      c = @entities.create("C")
      d = @entities.create("D")
      e = @entities.create("E")

      expect(@entities.withComponents([SoComponent, SuchComponent])).to.have.keys(b.toString(), c.toString())
      expect(@entities.withComponents([SoComponent])).to.have.keys(a.toString(), b.toString(), c.toString())
      expect(@entities.withComponents([SoComponent, SuchComponent, AmazeComponent])).to.have.keys(c.toString())
