require! {
  fs
  jsdom
  hilbert
}

error, window <- jsdom.env '' <[node_modules/snapsvg/dist/snap.svg.js]>
throw error if error

{Snap, document} = window

paper = Snap 300, 300
circle = paper.circle 150, 150, 100

fs.write-file 'test.svg' paper.node.outerHTML

window.close!
