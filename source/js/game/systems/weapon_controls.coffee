class Systems.WeaponControls extends System
  constructor: (@input) ->
    @vector = vec2.create()

  update: ->
    for id, entity of @engine.entities.withComponents("weapon", "controls", "rotation", "velocity", "position", "model")
      { weapon, controls, rotation, velocity, position, model } = entity

      weapon.cooldown -= 1 if weapon.cooldown

      if not weapon.cooldown and @input.isPressed(controls.shoot)
        weapon.cooldown = weapon.delay

        @engine.entities.create Entities.Bullet, (bullet) =>
          vec2.polar(@vector, rotation, 1)
          vec2.polar(bullet.velocity, rotation, 3 + vec2.dot(@vector, velocity))

          vec2.polar(bullet.position, rotation, model.boundingSphere.radius * 1.2)
          vec2.add(bullet.position, bullet.position, position)
