class Ship extends Serenade.Model
  @property "shape"
  @property "width"
  @property "height"

  constructor: (@width, @height) ->
    @shape = new c.Shape()
    @shape.regX = @height / 2
    @shape.regY = @width / 2
    @shape.graphics
      .setStrokeStyle(2, "round", "miter", 1)
      .beginStroke("#000000")
      .beginFill("#cc0000")
      .moveTo(0, 0)
      .lineTo(@height, @width / 2)
      .lineTo(0, @width)
      .lineTo(@height * 0.3, @width / 2)
      .closePath()
      .endFill()
      .endStroke()

class @Player extends Serenade.Model
  @property "speed", value: 4

  @property "ship"
  @property "position"
    get: ->
      new Point(@x, @y)
    set: (point) ->
      { @x, @y } = point

  @delegate "shape", to: "ship"
  @delegate "x", "y", "rotation", to: "shape"

  constructor: (move, left, right, shoot) ->
    @ship = new Ship(24, 30)
    @position = { x: 200, y: 200 }

    key [move, left, right, shoot].join(", "), "playing", (event) ->
      event.preventDefault()

    @shape.onTick = (timeElapsed) =>
      timeElapsed *= 0.1
      @rotation -= 5 * timeElapsed if key.isPressed(left)
      @rotation += 5 * timeElapsed if key.isPressed(right)
      @move(@speed * timeElapsed) if key.isPressed(move)

  move: (length) ->
    { x, y } = new Vector(length, @rotation).point
    @x += x
    @y += y
