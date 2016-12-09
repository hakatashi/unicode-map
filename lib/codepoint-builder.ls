require! {
  './util': {merge-maps}
}

flatten = (object, {start, end}) ->
  # Define model
  model =
    | object is \notdef
      type: \notdef
    | object is \tofu
      type: \tofu
    | object.has-own-property \font =>
      type: \font
      font-name: object.font
    | object.has-own-property \control =>
      type: \control
      short-name: object.control
    | object.has-own-property \svg =>
      type: \svg
    | otherwise => throw new Error 'Type not specified'

  if model.type is \control and typeof! model.short-name is \String
    model.short-name .= split '\n' .filter (.length > 0)

  if model.type in <[font svg]>
    for transform in <[transform scale skew translate rotate combining box]>
      if object[transform]?
        model[transform] = object[transform]

  map = new Map!

  # Calculate overrides first
  for key, value of object
    codepoints = key.split '..'

    continue unless codepoints.every (.match /[\da-f]{4,5}/i)

    codepoints .= map (parse-int _, 16)

    [submap-start, submap-end] =
      if codepoints.length is 1
        codepoints[0 0]
      else
        codepoints[0 1]

    submap = flatten value, do
      start: submap-start
      end: submap-end

    for codepoint from submap-start to submap-end
      map.set codepoint, submap.get codepoint

  # Interpolate by models
  for codepoint from start to end
    unless map.has codepoint
      clone = Object.assign {}, model

      if model.type is \control
        if typeof! model.short-name is \Array
          clone.short-name = clone.short-name[codepoint - start]

      map.set codepoint, clone

  map

module.exports = (object) ->
  maps = for key, value of object
    codepoints = key.split '..' .map (parse-int _, 16)

    [start, end] =
      if codepoints.length is 1
        codepoints[0 0]
      else
        codepoints[0 1]

    flatten value, {start, end}

  merge-maps maps
