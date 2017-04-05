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
        * now ->
            log "Composing #poster-svg..."
            compose-poster svg, config
      ]

    .then ([_, poster]) ->
      Promise.all [
        * now ->
            log "Writing #poster-svg..."
            fs.write-file poster-svg, poster
        * now ->
            log "Generating #poster-png..."
            convert-to-png poster
          .then (png) ->
            log "Writing #poster-png..."
            fs.write-file poster-png, png
      ]

    .then ->
      log "Generating #poster-pdf..."
      convert-to-pdf poster-svg, poster-pdf

.then ->
  log 'Done.'

.catch (error) ->
  console.error error
  process.exit 1
