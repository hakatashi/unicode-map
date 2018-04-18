require! {
  'mz/fs'
  './util': {log, to-hex}
  jsdom
  path
  hilbert: {Hilbert2d}
  progress: Progress
  xmlserializer
  'opentype.js'
  'camel-case'
  util
}

font-counts = new Map!

font-data =
  doulos:
    name: 'Doulos SIL 5.000'
    URL: 'http://software.sil.org/doulos/'
    author: 'SIL International'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Doulos/DoulosSIL-5.000/DoulosSIL-R.ttf'
  symbola:
    name: 'Symbola'
    URL: 'http://users.teilar.gr/~g1951d/'
    author: 'George Douros'
    license: 'Permissive License'
    licenseURL: 'http://users.teilar.gr/~g1951d/'
    path: 'Symbola/Symbola.ttf'
  ipamjm:
    name: 'IPA mj Mincho'
    URL: 'http://mojikiban.ipa.go.jp/1300.html'
    author: 'Information-technology Promotion Agency, Japan (IPA)'
    license: 'IPA Font License v1.0'
    licenseURL: 'http://ipafont.ipa.go.jp/ipa_font_license_v1-html'
    path: 'IPAmjm/ipamjm.ttf'
  ipaexm:
    name: 'IPA ex Mincho'
    URL: 'http://mojikiban.ipa.go.jp/1300.html'
    author: 'Information-technology Promotion Agency, Japan (IPA)'
    license: 'IPA Font License v1.0'
    licenseURL: 'http://ipafont.ipa.go.jp/ipa_font_license_v1-html'
    path: 'IPAexm/ipaexm00201/ipaexm.ttf'
  hanamin-a:
    name: 'Hanazono Mincho'
    URL: 'http://fonts.jp/hanazono/'
    author: 'GlyphWiki Project'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'hanazono/HanaMinA.ttf'
  free-serif:
    name: 'GNU FreeFont'
    URL: 'https://www.gnu.org/software/freefont/'
    author: 'GNU FreeFont Contributors'
    license: 'GPLv3+FE'
    licenseURL: 'https://www.gnu.org/software/freefont/license.html'
    path: 'FreeFont/freefont-20120503/FreeSerif.ttf'
  noto:
    name: 'Noto Fonts'
    URL: 'https://www.google.com/get/noto/'
    author: 'Google Inc.'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
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
  noto-ol-chiki:
    path: 'Noto/NotoSansOlChiki-Regular.ttf'
  noto-devanagari:
    path: 'Noto/NotoSerifDevanagari-Regular.ttf'
  noto-serif:
    path: 'Noto/NotoSerif-Regular.ttf'
  noto-tifinagh:
    path: 'Noto/NotoSansTifinagh-Regular.ttf'
  noto-yi:
    path: 'Noto/NotoSansYi-Regular.ttf'
  noto-cjk-jp:
    path: 'Noto/NotoSansCJKjp-Light.otf'
  noto-serif-jp:
    path: 'NotoSerifCJKjp/NotoSerifCJKjp-Regular.otf'
  scheherazade:
    name: 'Scheherazade 2.100'
    URL: 'http://software.sil.org/scheherazade/'
    author: 'SIL International'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Scheherazade/Scheherazade-2.100/Scheherazade-Regular.ttf'
  scheherazade-bold:
    path: 'Scheherazade/Scheherazade-2.100/Scheherazade-Bold.ttf'
  annapurna:
    name: 'Annapurna SIL 1.202'
    URL: 'http://software.sil.org/annapurna/'
    author: 'SIL International'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Annapurna/AnnapurnaSIL-1.202/AnnapurnaSIL-Regular.ttf'
  manjari:
    name: 'Manjari'
    URL: 'https://github.com/santhoshtr/Manjari'
    author: 'Santhosh Thottingal, Kavya Manohar'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Manjari/Manjari-Regular.ttf'
  norasi:
    name: 'Norasi'
    URL: 'https://linux.thai.net/projects/fonts-tlwg'
    author: 'The National Font Project (v.beta), Yannis Haralambous, Virach Sornlertlamvanich, and Anutara Tantraporn, with modification by Thai Linux Working Group (TLWG)'
    license: 'GPLv2+FE'
    licenseURL: 'https://github.com/tlwg/fonts-tlwg/blob/master/COPYING'
    path: 'tlwg/ttf-tlwg-0.5.0/Norasi.ttf'
  jomolhari:
    name: 'Jomolhari 000.003c'
    URL: 'https://collab.itc.virginia.edu/wiki/tibetan-script/Jomolhari.html'
    author: 'THL Staff'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Jomolhari/Jomolhari-alpha3c-0605331.ttf'
  padauk:
    name: 'Padauk 3.002'
    URL: 'http://software.sil.org/padauk/'
    author: 'SIL International'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Padauk/padauk-3.002/PadaukBook-Regular.ttf'
  quivira:
    name: 'Quivira 4.1'
    URL: 'http://www.quivira-font.com/'
    author: 'Alexander Lange'
    license: 'Permissive License'
    licenseURL: 'http://www.quivira-font.com/notes.php'
    path: 'Quivira/Quivira.otf'
  unbatang:
    name: 'UnBatang'
    URL: 'https://kldp.net/unfonts/'
    author: 'Koanughi Un, Won-kyu Park, and Jungshik Shin'
    license: 'GPLv2'
    licenseURL: 'http://www.gnu.org/licenses/gpl.txt'
    path: 'UnFonts/un-fonts/UnBatang.ttf'
  abyssinica:
    name: 'Abyssinica SIL 1.500'
    URL: 'http://software.sil.org/abyssinica/'
    author: 'SIL International'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Abyssinica/AbyssinicaSIL-1.500/AbyssinicaSIL-R.ttf'
  hancom:
    name: 'HCRBatang'
    URL: 'http://www.hancom.com/cs_center/csDownload.do'
    author: 'Hancom INC(HNC)'
    license: 'Permissive License'
    licenseURL: 'http://www.hancom.com/cs_center/csDownload.do'
    path: 'Hancom/HANBatang.ttf'
  mongolian-script:
    name: 'MongolianScript'
    URL: 'http://mongol.openmn.org/'
    author: 'Myataviin Erdenechimeg and Bolorsoft LLC'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'MongolianScript/fonts/MongolianScript.ttf'
  namdhinggo:
    name: 'Namdhinggo SIL 1.004'
    URL: 'http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=NamdhinggoSIL'
    author: 'SIL International'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Namdhinggo/NamdhinggoSIL/NamdhinggoSIL-R.ttf'
  dai-banna:
    name: 'Dai Banna SIL 2.200'
    URL: 'http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=daibannasil'
    author: 'SIL International'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'DaiBanna/dai-banna-2.200/DBSILBR.ttf'
  nishiki:
    name: 'Nishiki-teki Font'
    URL: 'http://hwm3.gyao.ne.jp/shiroi-niwatori/nishiki-teki.htm'
    author: 'Umihotaru'
    license: 'Permissive License'
    licenseURL: 'http://hwm3.gyao.ne.jp/shiroi-niwatori/faq.txt'
    path: 'Nishiki/nishiki-teki_3_35/nishiki-teki.ttf'
  mingzat:
    name: 'Mingzat 0.100'
    URL: 'http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=Mingzat'
    author: 'SIL International'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'Mingzat/Mingzat/Mingzat-R.ttf'
  ponomar:
    name: 'Ponomar Unicode'
    URL: 'http://www.ponomar.net/cu_support/fonts.html'
    author: 'Vlad Dorosh, Aleksandr Andreev, Yuri Shardt, and Nikita Simmons'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'PonomarUnicode/PonomarUnicode.ttf'
  junicode:
    name: 'Junicode'
    URL: 'http://junicode.sourceforge.net/'
    author: 'Peter S. Baker'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://scripts.sil.org/ofl'
    path: 'junicode/junicode/fonts/Junicode.ttf'
  btc:
    name: 'BTC.ttf'
    URL: 'https://en.bitcoin.it/wiki/Template:BTC'
    author: 'theymos'
    license: 'Public domain'
    licenseURL: ''
    path: 'BTC/BTC.ttf'
  observer-symbol:
    name: 'ObserverSymbol'
    URL: 'https://www.simongriffee.com/notebook/international-symbol-observer/'
    author: 'Simon Griffee'
    license: 'CC0 1.0 Universal'
    licenseURL: 'https://creativecommons.org/publicdomain/zero/1.0/'
    path: 'ObserverSymbol/ObserverSymbol.ttf'
  analecta:
    name: 'Analecta'
    URL: 'http://users.teilar.gr/~g1951d/'
    author: 'George Douros'
    license: 'Permissive License'
    licenseURL: 'http://users.teilar.gr/~g1951d/'
    path: 'Analecta/Analecta.otf'
  babel-stone:
    name: 'BabelStone Han'
    URL: 'http://www.babelstone.co.uk/Fonts/Han.html'
    author: 'Arphic Technology Co., Ltd.'
    license: 'Arphic Public License'
    licenseURL: 'http://ftp.gnu.org/non-gnu/chinese-fonts-truetype/LICENSE'
    path: 'BabelStoneHan/BabelStoneHan.ttf'
  open-sans:
    name: 'Open Sans'
    URL: 'http://www.opensans.com/'
    author: 'Steve Matteson and Google Corporation'
    license: 'Apache License v2'
    licenseURL: 'http://www.apache.org/licenses/LICENSE-2.0'
    path: 'OpenSans/OpenSans-Bold.ttf'
  dejavu:
    name: 'DejaVu Serif'
    URL: 'https://dejavu-fonts.github.io/'
    author: 'Bitstream'
    license: 'Free License'
    licenseURL: 'https://dejavu-fonts.github.io/License.html'
    path: 'DejaVu/dejavu-fonts-ttf-2.37/ttf/DejaVuSerif.ttf'
  jglao:
    name: 'JG Lao Times'
    URL: 'https://web.archive.org/web/20090729181203/http://geocities.com/jglavy/asian.html'
    author: 'GlavyFonts'
    license: 'Permissive License'
    licenseURL: 'https://web.archive.org/web/20090729181203/http://geocities.com/jglavy/asian.html'
    path: 'JGLao/JG LaoTimesOT.ttf'
  lisu:
    name: 'LisuUnicode'
    URL: 'http://phjamr.github.io/lisu.html'
    author: 'phjamr'
    license: 'SIL OFL 1.1'
    licenseURL: 'https://github.com/phjamr/LisuUnicode/blob/master/LICENSE.md'
    path: 'LisuUnicode/LisuUnicode-Regular.ttf'
  wakor:
    name: 'Wakor'
    URL: 'http://www.evertype.com/fonts/vai/'
    author: 'Jason Glavy'
    license: 'SIL OFL 1.1'
    licenseURL: 'http://www.evertype.com/fonts/vai/wakor-licence.html'
    path: 'Wakor/Wakor-4.0.7/Wakor.ttf'

load-fonts = ->
  Promise.all do
    for let name, {path: short-path} of font-data
      if short-path is undefined
        Promise.resolve {}
      else
        new Promise (resolve, reject) ->
          full-path = path.join __dirname, \../fonts, short-path
          opentype.load full-path, (error, font) ->
            if error then reject error else resolve "#name": font
  .then (fonts) ->
    new Promise (resolve, reject) ->
      log 'All fonts loaded.'
      resolve Object.assign {}, ...fonts

load-glyphs = ->
  fs.readdir path.join __dirname, \../data/glyphs
  .then (files) ->
    Promise.all do
      for let file in files when path.extname(file) is '.svg'
        fs.read-file path.join __dirname, \../data/glyphs, file .then (glyph) ->
          "#{camel-case path.basename file, '.svg'}": glyph
  .then (glyphs) ->
    log 'All glyphs loaded.'
    Object.assign {}, ...glyphs

module.exports = (codepoint-infos, config) ->
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

  defined-characters = 0
  early-mapped-characters = 0

  start-xy = hilbert.xy config.codepoint

  for code-point from config.codepoint til config.codepoint + 128 * 128
    {x, y} = hilbert.xy code-point

    x -= start-xy.x
    y -= start-xy.y

    codepoint-info = codepoint-infos.get code-point

    continue unless codepoint-info?

    glyph-infos =
      for let name, font of fonts
        {name, font, glyph: font.char-to-glyph String.from-code-point(codepoint-info?.codepoint or code-point)}

    unless codepoint-info.type is \notdef
      defined-characters++

    if codepoint-info.early is true
      early-mapped-characters++

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
      lines = codepoint-info.short-name.split '\\n'

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
          if codepoint-info.font-name.length is 1
            glyph-infos.find (.name is camel-case codepoint-info.font-name)
          else
            font-names = codepoint-info.font-name.map camel-case
            font-name = font-names.find ((name) -> glyph-infos.some (-> it.name is name and it.glyph.unicode isnt undefined))
            glyph-infos.find (-> it.name is font-name)
        else if process.env.DEBUG is \true
          glyph-infos.find (.glyph.unicode isnt undefined)
        else
          undefined

      if glyph-info isnt undefined
        font-group = paper.group!

        width = glyph-info.glyph.advance-width / glyph-info.font.units-per-em * block-size
        glyph-path = glyph-info.glyph.get-path (block-size - width) / 2, 25, block-size .to-path-data!
        path = paper.path glyph-path

        font-count-name =
          if glyph-info.name.starts-with 'noto'
            'noto'
          else if glyph-info.name.starts-with 'scheherazade'
            'scheherazade'
          else
            glyph-info.name

        unless font-counts.has font-count-name
          font-counts.set font-count-name, 0

        font-counts.set font-count-name, 1 + font-counts.get font-count-name

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
      temp-anchors = []
      anchor-group = paper.group!

      anchor-size = 2

      if x isnt 0x7F
        right-anchor1 = paper.line block-size, 0, block-size, anchor-size
        anchor-group.append right-anchor1

        right-anchor2 = paper.line block-size, block-size - anchor-size, block-size, block-size
        anchor-group.append right-anchor2

      if y isnt 0x7F
        bottom-anchor1 = paper.line 0, block-size, anchor-size, block-size
        anchor-group.append bottom-anchor1

        bottom-anchor2 = paper.line block-size - anchor-size, block-size, block-size, block-size
        anchor-group.append bottom-anchor2

      if x % 16 is 0 and x isnt 0 and y % 16 is 0 and y isnt 0
        big-anchor = paper.rect -anchor-size, -anchor-size, anchor-size * 2, anchor-size * 2
        big-anchor.transform 'rotate(45deg)'
        anchor-group.append big-anchor

      anchor-group.transform "translate(#{x * block-size} #{y * block-size})"
      anchors.append anchor-group

    if path-string.length is 0
      path-string += "M #{(x + 0.5) * block-size} #{(y + 0.5) * block-size} "
    else
      path-string += "L #{(x + 0.5) * block-size} #{(y + 0.5) * block-size} "

    progress.tick 128 if (code-point + 1) % 128 is 0

  anchors.attr do
    stroke-width: '0.5px'
    stroke: 'black'

  path = paper.path path-string
  path.attr do
    fill: 'none'
    stroke: 'black'
    stroke-opacity: 0.3
    stroke-width: 0.5
  path.prepend-to paper

  paper.node.set-attribute 'viewBox', '0 0 3840 3840'
  paper.node.set-attribute 'width', 7680
  paper.node.set-attribute 'height', 7680

  font-counts-list = Array.from font-counts
  font-counts-list.sort (a, b) -> b.1 - a.1
  font-license-text = font-counts-list.map ([font-name, font-count]) ->
    font = font-data[font-name]
    "#{font.name} by #{font.author} licensed under #{font.license}"
  .join '\n'
  font-count-text = font-counts-list.map ([font-name, font-count]) ->
    font = font-data[font-name]
    "#{font.name}: #{font-count}"
  .join '\n'

  console.log """

    ====== License notation ======

    #{font-license-text}
  """

  console.log """

    ====== Glyph count ======

    #{font-count-text}
  """

  console.log """

    ====== Statistics ======

  """

  console.log "Defined Characters: #{defined-characters}"
  console.log "Early Mapped Characters: #{early-mapped-characters}"

  log 'Rendering SVG...'

  svg = xmlserializer.serialize-to-string paper.node

  window.close!

  resolve svg
