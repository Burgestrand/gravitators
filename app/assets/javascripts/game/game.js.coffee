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
    get: -> c.Ticker.getPaused()
    set: (bool) -> c.Ticker.setPaused(bool)

  constructor: (container) ->
    @view = Serenade.render("game", this, this)

    @stage = new c.Stage($("canvas", @view))
    @world = new Container()
    @ships = new Container()
    @stage.addChild(@world.container, @ships.container)

    @join(new Player("W", "A", "D", "space"))

    c.Ticker.setFPS(60)
    c.Ticker.addListener(this)

    container.appendChild(@view)

  join: (player) ->
    @ships.push(player)

  debug: (message, type = "debug") ->
    @messages.unshift(DebugMessage.create(message, type))

  tick: (delta, paused) ->
    @fps = c.Ticker.getMeasuredFPS()
    @redraw()

  redraw: ->
    @stage.update()
