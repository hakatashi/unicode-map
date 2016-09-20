require! {
  'mz/fs'
  './lib/util': {log, now}
  './lib/download-fonts'
  './lib/load-codepoints'
  './lib/generate-svg'
  './lib/convert-to-png'
}

now ->
  log 'Downloading fonts...'
  download-fonts!

.then ->
  log 'Loading codepionts...'
  load-codepoints!

.then (codepoints) ->
  log 'Generating SVG...'
  generate-svg codepoints

.then (svg) ->
  log 'Converting to PNG...'

  Promise.all [
    * fs.write-file \test.svg svg
    * convert-to-png svg
      .then (png) ->
        log 'Writing PNG to file...'
        fs.write-file \test.png png
  ]

.then ->
  log 'Done.'
.catch (error) -> throw error
