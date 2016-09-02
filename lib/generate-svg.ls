require! {
  fs
  path
  './util': {log}
  jsdom
  hilbert: {Hilbert2d}
  xmlserializer
  'opentype.js'
}

font-data =
  doulos:
    path: 'Doulos/DoulosSIL-5.000/DoulosSIL-R.ttf'
    color: \purple
  symbola:
    path: 'Symbola/Symbola.ttf'
    color: 'cyan'
  emoji:
    path: 'Noto/NotoEmoji-Regular.ttf'
    color: 'yellow'
  ipamjm:
    path: 'IPAmjm/ipamjm.ttf'
    color: 'blue'
  ipaexm:
    path: 'IPAexm/ipaexm00201/ipaexm.ttf'
    color: 'black'
  hanamin-a:
    path: 'hanazono/HanaMinA.ttf'
    color: 'red'
  /*
  noto-jp:
    path: 'Noto/NotoSansCJKjp-Regular-unified.otf'
    color: 'pink'
  */

load-fonts = ->
  Promise.all do
    for let name, {path: short-path} of font-data
      new Promise (resolve, reject) ->
        full-path = path.join __dirname, \../fonts, short-path
        opentype.load full-path, (error, font) ->
          if error then reject error else resolve "#name": font
  .then (fonts) ->
    new Promise (resolve, reject) ->
      log 'All fonts loaded.'
      resolve Object.assign {}, ...fonts

module.exports = -> load-fonts!then (fonts) ->
  resolve, reject <- new Promise _

  error, window <- jsdom.env '' <[node_modules/snapsvg/dist/snap.svg.js]>
  return reject error if error

  {Snap, document} = window

  hilbert = new Hilbert2d 256

  paper = Snap 128 * 30, 128 * 30

  path-string = ''

  for code-point from 0 til 128 * 128
    {x, y} = hilbert.xy code-point

    glyph-infos =
      for let name, font of fonts
        {name, font, glyph: font.char-to-glyph String.from-code-point code-point}

    glyph-info = glyph-infos.find (.glyph.unicode isnt undefined)

    if glyph-info isnt undefined
      font-size = 30

      circle = paper.circle x * 30 + 15, y * 30 + 15, font-size / 2
      circle.attr do
        fill: font-data[glyph-info.name].color
        fill-opacity: 0.2

      width = glyph-info.glyph.advance-width / glyph-info.font.units-per-em * font-size
      glyph-path = glyph-info.glyph.get-path x * 30 + 15 - width / 2, y * 30 + 25, font-size .to-path-data!
      paper.path glyph-path

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
