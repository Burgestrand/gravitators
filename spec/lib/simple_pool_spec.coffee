require "../spec_helper"

describe "SimplePool", ->
  it "is a simple pool", ->
    SimplePool.same = true
    expect(SimplePool.same).to.equal(true)

  it "is not the sae pool", ->
    expect(SimplePool.same).to.be.undefined
