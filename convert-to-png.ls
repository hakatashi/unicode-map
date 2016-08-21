require! {
  svg2png
}

module.exports = (svg) ->
  svg-data = Buffer.from svg
  svg2png svg-data
