export log = (text) ->
  date = new Date!
  date-string = date.to-ISO-string!
  console.log "[#date-string] #text"

export merge-maps = (maps) ->
  flattened-maps = maps.map (-> Array.from it) .reduce ((a, b) -> a ++ b), []
  new Map flattened-maps

# Just executes specified function and returns result.
# Used to beautify indentation in promise chains
export now = -> it!

export to-hex = (codepoint) ->
  if codepoint < 0x10000
    ('0000' + codepoint.to-string 16).slice -4
  else
    codepoint.to-string 16
