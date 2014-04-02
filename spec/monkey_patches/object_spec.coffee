describe "Object", ->
  describe ".update", ->
    it "updates existing properties with given values", ->
      subject = { a: "A", b: "B", c: "C" }
      Object.update(subject, b: "X", d: "Y")
      expect(subject).to.deep.equal(a: "A", b: "X", c: "C")

    it "can update existing properties with falsy values", ->
      subject = { a: "A", b: "B", c: "C" }
      Object.update(subject, b: false, c: undefined)
      expect(subject).to.deep.equal(a: "A", b: false, c: undefined)

    it "does nothing if not given any new properties", ->
      subject = { a: "A", b: "B", c: "C" }
      Object.update(subject)
      expect(subject).to.deep.equal(a: "A", b: "B", c: "C")
