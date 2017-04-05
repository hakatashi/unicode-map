require! {
  'mz/fs'
  './util': {log}
  jsdom
  progress: Progress
  xmlserializer
}

module.exports = (chart-svg, config) ->
  poster-svg <- fs.read-file "data/layouts/#{config.layout}.svg" .then

  resolve, reject <- new Promise _

  error, window <- jsdom.env '' [require.resolve 'snapsvg']
  return reject error if error

  {Snap, document} = window

  paper = Snap 7016 9933 # 594x841mm * 300dpi

  root-group = paper.group!
  root-group.transform "scale(#{300 / 72})"

  chart = paper.group!append-to root-group
  poster = paper.group!append-to root-group
  poster.transform "scale(#{72 / 300})"

  chart-element = Snap.parse chart-svg
  for child in Array::slice.call chart-element.node.children, 0
    chart.append child

  poster-element = Snap.parse poster-svg
  for child in Array::slice.call poster-element.node.children, 0
    poster.append child

  chart.transform "translate(28.35, 728.5) scale(#{1627.09 / 3840})"

  svg = xmlserializer.serialize-to-string paper.node
  window.close!

  resolve svg
