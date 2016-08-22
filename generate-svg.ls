require! {
  fs
  path
  './util': {log}
  jsdom
  hilbert: {Hilbert2d}
  xmlserializer
  'opentype.js'
}

fonts =
  symbola: 'Symbola/Symbola.ttf'
  emoji: 'Noto/NotoEmoji-Regular.ttf'
  ipaexm: 'IPAexm/ipaexm00201/ipaexm.ttf'
  hanamin-a: 'hanazono/HanaMinA.ttf'
  #noto-jp: 'Noto/NotoSansCJKjp-Regular.otf'

load-fonts = ->
  Promise.all do
    for let name, short-path of fonts
      new Promise (resolve, reject) ->
        full-path = path.join __dirname, \fonts, short-path
        opentype.load full-path, (error, font) ->
          if error then reject error else resolve "#name": font
  .then (fonts) ->
    new Promise (resolve, reject) ->
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

    glyphs =
      for let name, font of fonts
        font.char-to-glyph String.from-code-point code-point

    glyph = glyphs.find (.unicode isnt undefined) or glyphs.0

    font-size = 30
    width = glyph.advance-width / fonts.symbola.units-per-em * font-size
    glyph-path = glyph.get-path x * 30 + 15 - width / 2, y * 30 + 20, font-size .to-path-data!
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
