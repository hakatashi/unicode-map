require! {
  'mz/fs'
  './util': {log}
  './download-fonts'
  './generate-svg'
  './convert-to-png'
}

log "Downloading fonts..."
download-fonts!

.then ->
  log "Generating SVG..."
  generate-svg!

.then (svg) ->
  log "Converting to PNG..."

  Promise.all do
    * fs.write-file \test.svg svg
    * convert-to-png svg
      .then (png) ->
        log "Writing PNG to file..."
        fs.write-file \test.png png

.then ->
  log "Done."
.catch (error) -> throw error
