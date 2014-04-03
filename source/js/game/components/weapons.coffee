allocator = ->
  {
    type: "default",
    delay: 20,
    cooldown: 0,
  }
initializer = (weapon, [type]) ->
  weapon.type = type

Components.Weapon = new SimplePool(allocator, initializer)
