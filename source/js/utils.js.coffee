@$ = (s, o = document) -> o.querySelector(s)
@$$ = (s, o = document) -> o.querySelectorAll(s)
@at = (o, args...) -> o.addEventListener(args...)
@c = createjs
