require! {
  'mz/fs'
  './lib/util': {log, now}
  './lib/download-fonts'
  './lib/load-codepoints'
  './lib/generate-svg'
  './lib/convert-to-png'
  './lib/convert-to-pdf'
  './lib/compose-poster'
  './configs'
  'bluebird': Promise
}

now ->
  log 'Downloading fonts...'
  download-fonts!

.then ->
  log 'Loading codepionts...'
  load-codepoints!

.then (codepoints) ->

  Promise.map-series configs, (config) ->
    return Promise.resolve! if config.name isnt 'bmp-2'
    chart-svg = "#{config.name}-chart.svg"
    poster-svg = "#{config.name}-poster.svg"
    poster-png = "#{config.name}-poster.png"
    poster-pdf = "#{config.name}-poster.pdf"

    now ->
      log "Generating #{config.name} SVG..."
      generate-svg codepoints, config

    .then (svg) ->
      Promise.all [
        * now ->
            log "Writing #chart-svg..."
            fs.write-file chart-svg, svg
      ]

.then ->
  log 'Done.'

.catch (error) ->
  console.error error
  process.exit 1
