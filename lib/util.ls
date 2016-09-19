export log = (text) ->
  date = new Date!
  date-string = date.to-ISO-string!
  console.log "[#date-string] #text"

export merge-maps = (maps) ->
  flatten-maps = maps.map (-> Array.from it) .reduce ((a, b) -> a ++ b), []
  new Map flatten-maps
