require! {
  'file-url'
  svg2png
  'mz/fs'
}

fs.read-file 'test.svg'
.then svg2png
.then -> fs.write-file 'test.png' it
.then -> console.log 'done'
.catch -> throw it
