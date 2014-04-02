emptyObject = {}
Object.update = (subject, attributes = emptyObject) ->
  for own key of subject
    if key of attributes
      subject[key] = attributes[key]
  subject
