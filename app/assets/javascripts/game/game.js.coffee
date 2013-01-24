class @Game extends Serenade.Model
  @collection "messages"

  @property "fps"
    format: (value) ->
      Math.round(value or 0, 2)

  constructor: (@element) ->
    @stage = new c.Stage(@element)

    parent = @element.parentNode
    parent.insertAfter(@element, Serenade.render("console", this))
    parent.insertAfter(@element, Serenade.render("info", this))

    c.Ticker.setFPS(30)
    c.Ticker.addListener(this)

    @debug("Stage loaded!")

  debug: (message, type = "debug") ->
    @messages.unshift(DebugMessage.create(message, type))

  tick: (delta, paused)->
    @fps = c.Ticker.getMeasuredFPS()
