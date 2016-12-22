require! {
  path
  'mz/fs'
  './util': {log, to-hex}
  jsdom
  path
  hilbert: {Hilbert2d}
  progress: Progress
  xmlserializer
  'opentype.js'
  'camel-case'
}

font-data =
  doulos:
    path: 'Doulos/DoulosSIL-5.000/DoulosSIL-R.ttf'
  symbola:
    path: 'Symbola/Symbola.ttf'
  emoji:
    path: 'Noto/NotoEmoji-Regular.ttf'
  ipamjm:
    path: 'IPAmjm/ipamjm.ttf'
  ipaexm:
    path: 'IPAexm/ipaexm00201/ipaexm.ttf'
  hanamin-a:
    path: 'hanazono/HanaMinA.ttf'
  open-sans:
    path: 'OpenSans/OpenSans-Bold.ttf'
  free-serif:
    path: 'FreeFont/freefont-20120503/FreeSerif.ttf'
  noto-hebrew:
    path: 'Noto/NotoSansHebrew-Regular.ttf'
  noto-arabic:
    path: 'Noto/NotoNaskhArabic-Regular.ttf'
  noto-syriac:
    path: 'Noto/NotoSansSyriacEastern-Regular.ttf'
  noto-nko:
    path: 'Noto/NotoSansNKo-Regular.ttf'
  noto-samaritan:
    path: 'Noto/NotoSansSamaritan-Regular.ttf'
  noto-mandaic:
    path: 'Noto/NotoSansMandaic-Regular.ttf'
  noto-bengali:
    path: 'Noto/NotoSerifBengali-Regular.ttf'
  noto-gujarati:
    path: 'Noto/NotoSerifGujarati-Regular.ttf'
  noto-tamil:
    path: 'Noto/NotoSerifTamil-Regular.ttf'
  noto-telugu:
    path: 'Noto/NotoSerifTelugu-Regular.ttf'
  noto-kannada:
    path: 'Noto/NotoSerifKannada-Regular.ttf'
  noto-malayalam:
    path: 'Noto/NotoSerifMalayalam-Regular.ttf'
  noto-lao:
    path: 'Noto/NotoSerifLao-Regular.ttf'
  noto-tibetan:
    path: 'Noto/NotoSansTibetan-Regular.ttf'
  noto-georgian:
    path: 'Noto/NotoSerifGeorgian-Regular.ttf'
  noto-cherokee:
    path: 'NotoSansCherokee/NotoSansCherokee-Regular.ttf'
  noto-canadian-aboriginal:
    path: 'Noto/NotoSansCanadianAboriginal-Regular.ttf'
  noto-ogham:
    path: 'Noto/NotoSansOgham-Regular.ttf'
  noto-runic:
    path: 'Noto/NotoSansRunic-Regular.ttf'
  noto-tagalog:
    path: 'Noto/NotoSansTagalog-Regular.ttf'
  noto-tagbanwa:
    path: 'Noto/NotoSansTagbanwa-Regular.ttf'
  noto-khmer:
    path: 'Noto/NotoSerifKhmer-Regular.ttf'
  noto-tai-tham:
    path: 'Noto/NotoSansTaiTham-Regular.ttf'
  noto-balinese:
    path: 'Noto/NotoSansBalinese-Regular.ttf'
  noto-sundanese:
    path: 'Noto/NotoSansSundanese-Regular.ttf'
  noto-batak:
    path: 'Noto/NotoSansBatak-Regular.ttf'
  scheherazade:
    path: 'Scheherazade/Scheherazade-2.100/Scheherazade-Regular.ttf'
  annapurna:
    path: 'Annapurna/AnnapurnaSIL-1.201/AnnapurnaSIL-Regular.ttf'
  manjari:
    path: 'Manjari/Manjari-Regular.ttf'
  norasi:
    path: 'tlwg/ttf-tlwg-0.5.0/Norasi.ttf'
  jomolhari:
    path: 'Jomolhari/Jomolhari-alpha3c-0605331.ttf'
  padauk:
    path: 'Padauk/padauk-3.002/PadaukBook-Regular.ttf'
  quivira:
    path: 'Quivira/Quivira.otf'
  unbatang:
    path: 'UnFonts/un-fonts/UnBatang.ttf'
  abyssinica:
    path: 'Abyssinica/AbyssinicaSIL-1.500/AbyssinicaSIL-R.ttf'
  hancom:
    path: 'Hancom/HANBatang.ttf'
  mongolian-script:
    path: 'MongolianScript/fonts/MongolianScript.ttf'
  namdhinggo:
    path: 'Namdhinggo/NamdhinggoSIL/NamdhinggoSIL-R.ttf'
  dai-banna:
    path: 'DaiBanna/dai-banna-2.200/DBSILBR.ttf'
  nishiki:
    path: 'Nishiki/nishiki-teki_3_00/nishiki-teki.ttf'

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
  fs.readdir path.join __dirname, \../glyphs
  .then (files) ->
    Promise.all do
      for let file in files when path.extname(file) is '.svg'
        fs.read-file path.join __dirname, \../glyphs, file .then (glyph) ->
          "#{camel-case path.basename file, '.svg'}": glyph
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

    if codepoint-info?.type is \notdef
      notdef-group = paper.group!

      # Draw box
      notdef = Snap.parse custom-glyphs.notdef
      for child in Array::slice.call notdef.node.children, 0
        notdef-group.append child

      notdef-group.attr transform: "translate(#{x * block-size} #{y * block-size}) scale(#{block-size / 2048})"

      glyphs.append notdef-group
    else if codepoint-info?.type is \tofu
      tofu-group = paper.group!

      # Draw box
      tofu = Snap.parse custom-glyphs.tofu
      for child in Array::slice.call tofu.node.children, 0
        tofu-group.append child

      tofu-group.attr transform: "translate(#{x * block-size} #{y * block-size}) scale(#{block-size / 2048})"

      glyphs.append tofu-group
    else if codepoint-info?.type is \control
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
    else if codepoint-info?.type is \svg
      svg-font-group = paper.group!

      svg-group = paper.group!

      glyph-svg = Snap.parse custom-glyphs["u#{to-hex code-point}"]
      for child in Array::slice.call glyph-svg.node.children, 0
        svg-group.append child

      # Transform
      transform = Snap.matrix 1, 0, 0, 1, 0, 0
      transform.translate x * block-size, y * block-size
      if codepoint-info?.transform
        transform.scale block-size
        transform.translate 0.5, 0.5
        transform.add Snap._.transform2matrix Snap._.svg-transform2string codepoint-info?.transform
        transform.translate -0.5, -0.5
        transform.scale 1 / block-size
      transform.scale block-size / 1024
      svg-group.transform transform

      svg-font-group.append svg-group

      if codepoint-info?.box
        box-group = paper.group!

        box = Snap.parse custom-glyphs.control-box
        for child in Array::slice.call box.node.children, 0
          box-group.append child

        box-group.transform "translate(#{x * block-size} #{y * block-size}) scale(#{block-size / 2048})"

        svg-font-group.append box-group

      if codepoint-info?.combining
        combining-circle-group = paper.group!

        combining-circle = Snap.parse custom-glyphs.combining-circle
        for child in Array::slice.call combining-circle.node.children, 0
          combining-circle-group.append child

        combining-circle-group.transform "translate(#{x * block-size} #{y * block-size}) scale(#{block-size / 1024})"

        svg-font-group.append combining-circle-group

      glyphs.append svg-font-group
    else
      glyph-info =
        if codepoint-info?.type is \font
          glyph-infos.find (.name is camel-case codepoint-info.font-name)
        else if process.env.DEBUG is \true
          glyph-infos.find (.glyph.unicode isnt undefined)
        else
          undefined

      if glyph-info isnt undefined
        font-group = paper.group!

        width = glyph-info.glyph.advance-width / glyph-info.font.units-per-em * block-size
        glyph-path = glyph-info.glyph.get-path (block-size - width) / 2, 25, block-size .to-path-data!
        path = paper.path glyph-path

        # Transform
        transform = Snap.matrix 1, 0, 0, 1, 0, 0
        # SVG Transform operation occurs by last-in-first-out order
        # http://stackoverflow.com/q/27635272
        transform.translate x * block-size, y * block-size
        if codepoint-info?.transform
          transform.scale block-size
          transform.translate 0.5, 0.5
          transform.add Snap._.transform2matrix Snap._.svg-transform2string codepoint-info?.transform
          transform.translate -0.5, -0.5
          transform.scale 1 / block-size
        path.transform transform

        font-group.append path

        if codepoint-info?.combining
          combining-circle-group = paper.group!

          combining-circle = Snap.parse custom-glyphs.combining-circle
          for child in Array::slice.call combining-circle.node.children, 0
            combining-circle-group.append child

          combining-circle-group.transform "translate(#{x * block-size} #{y * block-size}) scale(#{block-size / 1024})"

          font-group.append combining-circle-group

        if codepoint-info?.box
          box-group = paper.group!

          box = Snap.parse custom-glyphs.control-box
          for child in Array::slice.call box.node.children, 0
            box-group.append child

          box-group.transform "translate(#{x * block-size} #{y * block-size}) scale(#{block-size / 2048})"

          font-group.append box-group

        glyphs.append font-group

    if codepoint-info?.type isnt undefined
      anchor = paper.rect -0.5, -0.5, 1, 1
      anchor.transform "translate(#{(x + 1) * block-size} #{(y + 1) * block-size}) rotate(45deg)"
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
