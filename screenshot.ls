require! {
  nightmare: Nightmare
  'file-url'
  'svg-to-png'
  svg2png
  svgexport
  'pn/fs'
}

nightmare = Nightmare do
  width: 4000
  height: 4000

fs.read-file 'test.svg'
.then svg2png
.then -> fs.write-file 'test.png' it
.then -> console.log 'done'
.catch -> throw it
