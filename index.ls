require! {
  'mz/fs'
  './download-fonts'
  './generate-svg'
  './convert-to-png'
}

console.log "Downloading fonts..."
download-fonts!

.then ->
  console.log "Generating SVG..."
  generate-svg!

.then (svg) ->
  console.log "Writing SVG to file..."
  console.log "Converting to PNG..."

  Promise.all do
    * fs.write-file \test.svg svg
    * convert-to-png svg
      .then (png) ->
        console.log "Writing PNG to file..."
        fs.write-file \test.png png

.then ->
  console.log "Done."
.catch (error) -> throw error
