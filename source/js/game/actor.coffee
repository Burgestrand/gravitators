class @Actor extends GameObject
  @attribute "body"

  collide: (entity, engine) ->
    if entity instanceof Actor
      console.log "#{@} collided with #{entity}"
    else
      console.log "#{@} crashed!"

  update: (fps) ->
