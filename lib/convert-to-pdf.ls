require! {
  nightmare: Nightmare
  'file-url'
}

module.exports = (svg-path, pdf-path) ->
  nightmare = Nightmare!

  nightmare
  .goto file-url svg-path
  .evaluate ->
    svg = document.query-selector 'svg'
    svg.set-attribute 'viewBox', '0 0 7016 9933'
    svg.set-attribute 'width', '594mm'
    svg.set-attribute 'height', '841mm'
  .pdf pdf-path, do
    margins-type: 1
    page-size:
      width: 594000
      height: 841000
      print-background: false
      landscape: false
  .end!
