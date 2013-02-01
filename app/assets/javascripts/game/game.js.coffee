class @Game extends Serenade.Model
  @property "width", value: 1024, format: Formatter.px
  @property "height", value: 576, format: Formatter.px

  @collection "messages"

  @property "fps"
    format: (value) ->
      value = Math.round(value or 0, 2)
      integer = Math.floor(value)
      decimal = Math.round((value - integer) * 100)
      "#{integer.lpad(2)}.#{decimal.lpad(2)}"

  @property "paused"
    get: ->
      c.Ticker.getPaused()
    set: (bool) ->
      key.setScope({ false: "playing", true: "paused" }[bool])
      c.Ticker.setPaused(bool)

  constructor: (container) ->
    @view = Serenade.render("game", this, this)

    @stage = new c.Stage($("canvas", @view))
    @ships = new Container()
    @stage.addChild(@ships.shape)

    ship = new Ship(24, 30, "#cc0000")
    ship.position = 200
    ship.weapon = new Weapon()
    window.player1 = new Player(ship, accelerate: "W", retardate: "S", left: "A", right: "D", shoot: "space")
    @ships.push(player1)

    c.Ticker.setFPS(48)
    c.Ticker.addListener(this)
    @paused = false

    container.appendChild(@view)

  debug: (message, type = "debug") ->
    @messages.unshift(DebugMessage.create(message, type))

  tick: (delta, paused) ->
    @fps = c.Ticker.getMeasuredFPS()
    @redraw(delta)

  redraw: ->
    @stage.update(arguments...)
