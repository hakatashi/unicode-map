require! {
  './expect'
  '../lib/codepoint-builder'
}

{describe: Describe, it: It} = global

assets =
  * * 'extracts hex key and convert it to number'
    * F1B1: font: \testfont
    * 0xF1B1:
        type: \font
        font-name: \testfont

  * * 'recognizes codepoints over U+FFFF'
    * D109A: font: \testfont
    * 0xD109A:
        type: \font
        font-name: \testfont

  * * 'extracts code point range to the series of keys'
    * '0150..0153': font: \testfont
    * 0x0150:
        type: \font
        font-name: \testfont
      0x0151:
        type: \font
        font-name: \testfont
      0x0152:
        type: \font
        font-name: \testfont
      0x0153:
        type: \font
        font-name: \testfont

  * * 'accepts additional parameters'
    * '535A':
        font: \testfont
        scale: 0.5
    * 0x535A:
        type: \font
        font-name: \testfont
        scale: 0.5

  * * 'supports nested notation'
    * '535A..535F':
        font: \font1
        '535B':
          font: \font2
        '535D..535E':
          font: \font3
    * 0x535A:
        type: \font
        font-name: \font1
      0x535B:
        type: \font
        font-name: \font2
      0x535C:
        type: \font
        font-name: \font1
      0x535D:
        type: \font
        font-name: \font3
      0x535E:
        type: \font
        font-name: \font3
      0x535F:
        type: \font
        font-name: \font1

  * * 'recognizes glyphs of type control'
    * '0102': control: \NUL
    * 0x0102:
        type: \control
        short-name: \NUL

  * * 'splats array of short-names into each characters'
    * '535A..535C': control: <[NUL SP CR]>
    * 0x535A:
        type: \control
        short-name: \NUL
      0x535B:
        type: \control
        short-name: \SP
      0x535C:
        type: \control
        short-name: \CR

  * * 'splats lines of short-names into each characters'
    * '535A..535C': control: '''
        NUL
        SP

        CR

      '''
    * 0x535A:
        type: \control
        short-name: \NUL
      0x535B:
        type: \control
        short-name: \SP
      0x535C:
        type: \control
        short-name: \CR

  * * 'recognizes glyphs of type svg'
    * '0102': svg: true
    * 0x0102:
        type: \svg

  * * 'recognizes glyphs of type notdef'
    * '0102': 'notdef'
    * 0x0102:
        type: \notdef

<- Describe 'Code Point Builder'

for let asset in assets
  It asset.0, ->
    expect codepoint-builder asset.1 .to.be.map asset.2
