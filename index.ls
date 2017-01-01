require! {
  'mz/fs'
  './lib/util': {log, now}
  './lib/download-fonts'
  './lib/load-codepoints'
  './lib/generate-svg'
  './lib/convert-to-png'
  './lib/convert-to-pdf'
  './lib/compose-poster'
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
  Promise.all [
    * now ->
        log 'Writing chart.svg'
        fs.write-file \chart.svg svg
      .then ->
        log 'Generating chart.png...'
        convert-to-png svg
      .then (png) ->
        log 'Writing chart.png...'
        fs.write-file \chart.png png
      .then ->
        log 'Composing poster.svg...'
        compose-poster svg
      .then (poster) ->
        log 'Writing poster.svg...'
        fs.write-file \poster.svg poster
      .then ->
        log 'Generating poster.pdf...'
        convert-to-pdf \poster.svg \poster.pdf
  ]

.then ->
  log 'Done.'

.catch (error) ->
  console.error error
