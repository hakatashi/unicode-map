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
  ...

<- Describe 'Code Point Builder'

for asset in assets
  It asset.0, ->
    expect codepoint-builder asset.1 .to.be.map asset.2
