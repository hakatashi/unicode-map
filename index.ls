require! {
  'mz/fs'
  './lib/util': {log, now}
  './lib/download-fonts'
  './lib/load-codepoints'
  './lib/generate-svg'
  './lib/convert-to-png'
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
  log 'Composing Poster...'

  Promise.all [
    * fs.write-file \chart.svg svg
    * compose-poster svg
      .then (poster) ->
        log 'Writing poster.svg to file...'
        fs.write-file \poster.svg poster
  ]

.then ->
  log 'Done.'
.catch (error) -> throw error
