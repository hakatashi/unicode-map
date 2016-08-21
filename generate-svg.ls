require! {
  fs
  './util': {log}
  jsdom
  hilbert: {Hilbert2d}
  xmlserializer
}

module.exports = ->
  resolve, reject <- new Promise _

  error, window <- jsdom.env '' <[node_modules/snapsvg/dist/snap.svg.js]>
  return reject error if error

  log 'Loaded jsdom environment...'

  {Snap, document} = window

  hilbert = new Hilbert2d 256

  paper = Snap 128 * 30, 128 * 30

  path-string = ''

  for code-point from 0 til 128 * 128
    {x, y} = hilbert.xy code-point
    text = paper.text x * 30 + 15, y * 30 + 25, String.from-code-point code-point
    text.attr do
      text-anchor: \middle
      font-size: \26px

    if path-string.length is 0
      path-string += "M #{x * 30 + 15} #{y * 30 + 15} "
    else
      path-string += "L #{x * 30 + 15} #{y * 30 + 15} "

  path = paper.path path-string
  path.attr do
    fill: 'none'
    stroke: 'red'
    stroke-opacity: 0.3
    stroke-width: 3
  path.prepend-to paper

  log 'Rendering SVG...'

  svg = xmlserializer.serialize-to-string paper.node

  window.close!

  resolve svg
