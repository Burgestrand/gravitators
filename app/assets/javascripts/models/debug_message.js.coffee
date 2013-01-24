class @DebugMessage extends Serenade.Model
  @property "message"
  @property "type"
  @property "timestamp"
    format: (date) ->
      h  = date.getHours()
      m  = date.getMinutes()
      s  = date.getSeconds()
      ms = date.getMilliseconds()
      "#{h.lpad(2)}:#{m.lpad(2)}:#{s.lpad(2)}.#{ms.lpad(3)}"

  @create: (message, type) ->
    new this({ timestamp: new Date(), message, type })
