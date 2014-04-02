describe "Math", ->
  specify ".deg2rad converts degrees to radians", ->
    expect(Math.deg2rad(180)).to.equal(Math.PI)
    expect(Math.deg2rad(90)).to.equal(Math.PI / 2)
