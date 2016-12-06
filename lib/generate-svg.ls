require! {
  path
  'mz/fs'
  './util': {log}
  jsdom
  hilbert: {Hilbert2d}
  progress: Progress
  xmlserializer
  'opentype.js'
  'camel-case'
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
  open-sans:
    path: 'OpenSans/OpenSans-Bold.ttf'
    color: 'red'
  /*
  noto-jp:
    path: 'Noto/NotoSansCJKjp-Regular-unified.otf'
    color: 'pink'
  */

glyph-data =
  control-box: 'control-box.svg'

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

load-glyphs = ->
  Promise.all do
    for let name, short-path of glyph-data
      fs.read-file path.join __dirname, \../glyphs, short-path .then (glyph) ->
        "#name": glyph
  .then (glyphs) ->
    log 'All glyphs loaded.'
    Object.assign {}, ...glyphs

module.exports = (codepoint-infos) ->
  [fonts, custom-glyphs] <- Promise.all [
    load-fonts!
    load-glyphs!
  ] .then

  resolve, reject <- new Promise _

  error, window <- jsdom.env '' [require.resolve 'snapsvg']
  return reject error if error

  {Snap, document} = window

  hilbert = new Hilbert2d 256

  block-size = 30

  paper = Snap 128 * block-size, 128 * block-size

  path-string = ''

  progress = new Progress 'Generating... [:bar] :current glyphs :elapseds' do
    incomplete: ' '
    width: 40
    total: 128 * 128

  anchors = paper.group!
  glyphs = paper.group!

  for code-point from 0 til 128 * 128
    {x, y} = hilbert.xy code-point

    glyph-infos =
      for let name, font of fonts
        {name, font, glyph: font.char-to-glyph String.from-code-point code-point}

    codepoint-info = codepoint-infos.get code-point

    if codepoint-info?.type is \control
      control-box-group = paper.group!

      # Draw box
      control-box = Snap.parse custom-glyphs.control-box
      for child in Array::slice.call control-box.node.children, 0
        control-box-group.append child

      # Draw text
      text-font = fonts.open-sans
      text-size = 768
      lines = codepoint-info.short-name.split '/'

      for line, line-index in lines
        text-path = text-font.get-path line, 1024, 1024, text-size .to-path-data!
        text = paper.path text-path
        text-width = text-font.string-to-glyphs line .reduce do
          * (a, b) -> a + b.advance-width / text-font.units-per-em * text-size
          * 0
        text.attr transform: "translate(#{- text-width / 2} #{(line-index - lines.length / 2 + 0.85) * text-size})"
        control-box-group.append text

      control-box-group.attr transform: "translate(#{x * block-size} #{y * block-size}) scale(#{block-size / 2048})"

      glyphs.append control-box-group
    else
      glyph-info =
        if codepoint-info?.type is \font
          glyph-infos.find (.name is camel-case codepoint-info.font-name)
        else
          glyph-infos.find (.glyph.unicode isnt undefined)

      if glyph-info isnt undefined
        width = glyph-info.glyph.advance-width / glyph-info.font.units-per-em * block-size
        glyph-path = glyph-info.glyph.get-path (block-size - width) / 2, 25, block-size .to-path-data!
        path = paper.path glyph-path
        path.attr transform: "translate(#{x * block-size} #{y * block-size})"
        glyphs.append path

    anchor = paper.rect -0.5, -0.5, 1, 1
    anchor.transform "translate(#{x * block-size} #{y * block-size}) rotate(45deg)"
    anchors.append anchor

    if path-string.length is 0
      path-string += "M #{(x + 0.5) * block-size} #{(y + 0.5) * block-size} "
    else
      path-string += "L #{(x + 0.5) * block-size} #{(y + 0.5) * block-size} "

    progress.tick 128 if (code-point + 1) % 128 is 0

  path = paper.path path-string
  path.attr do
    fill: 'none'
    stroke: 'black'
    stroke-opacity: 1
    stroke-width: 0.2
  path.prepend-to paper

  paper.node.set-attribute 'viewBox', '0 0 3840 3840'
  paper.node.set-attribute 'width', 7680
  paper.node.set-attribute 'height', 7680

  log 'Rendering SVG...'

  svg = xmlserializer.serialize-to-string paper.node

  window.close!

  resolve svg
