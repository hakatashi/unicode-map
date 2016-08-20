require! {
  fs
  jsdom
  hilbert: {Hilbert2d}
  xmlserializer
}

error, window <- jsdom.env '' <[node_modules/snapsvg/dist/snap.svg.js]>
throw error if error

{Snap, document} = window

hilbert = new Hilbert2d 256

paper = Snap 2000, 2000

for code-point from 0 til 64 * 64
  {x, y} = hilbert.xy code-point
  paper.text x * 30, y * 30 + 30, String.from-code-point code-point

fs.write-file 'test.svg' xmlserializer.serialize-to-string paper.node

window.close!
