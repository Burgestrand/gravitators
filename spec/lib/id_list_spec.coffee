describe "IDList", ->
  it "creates new IDs when there are none to be reused", ->
    list = new IDList()
    a = list.create()
    b = list.create()
    expect(a).not.to.equal(b)

  it "re-uses previously existing IDs", ->
    list = new IDList()
    a = list.create()
    list.release(a)
    b = list.create()
    expect(a).to.equal(b)

  it "can be iterated over, but does not guarantee order", ->
    list = new IDList()
    toArray = (list) ->
      id for id in list

    expect(toArray(list)).to.be.empty
    a = list.create()
    expect(toArray(list)).to.have.members([a])
    b = list.create()
    expect(toArray(list)).to.have.members([a, b])
    c = list.create()
    expect(toArray(list)).to.have.members([a, b, c])
    d = list.create()
    expect(toArray(list)).to.have.members([a, b, c, d])
    list.release(b)
    expect(toArray(list)).to.have.members([a, d, c])
    e = list.create()
    expect(toArray(list)).to.have.members([a, d, c, e])
    expect(b).to.equal(e)
