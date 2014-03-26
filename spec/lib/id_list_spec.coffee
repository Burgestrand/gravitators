describe "IDList", ->
  beforeEach ->
    @list = new IDList()

  it "creates new IDs when there are none to be reused", ->
    a = @list.create()
    b = @list.create()
    expect(a).not.to.equal(b)

  it "re-uses previously existing IDs", ->
    a = @list.create()
    @list.release(a)
    b = @list.create()
    expect(a).to.equal(b)

  describe "#forEach()", ->
    beforeEach ->
      @toArray = (list) ->
        ids = []
        list.forEach (id) -> ids.push(id)
        ids

    it "iterates over in-use IDs, but does not guarantee order", ->
      expect(@toArray(@list)).to.be.empty
      a = @list.create()
      expect(@toArray(@list)).to.have.members([a])
      b = @list.create()
      expect(@toArray(@list)).to.have.members([a, b])
      c = @list.create()
      expect(@toArray(@list)).to.have.members([a, b, c])
      d = @list.create()
      expect(@toArray(@list)).to.have.members([a, b, c, d])
      @list.release(b)
      expect(@toArray(@list)).to.have.members([a, d, c])
      e = @list.create()
      expect(@toArray(@list)).to.have.members([a, d, c, e])
      expect(b).to.equal(e)
