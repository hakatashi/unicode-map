export log = (text) ->
  date = new Date!
  date-string = date.to-ISO-string!
  console.log "[#date-string] #text"
