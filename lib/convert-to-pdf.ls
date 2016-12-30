require! {
  nightmare: Nightmare
  'file-url'
}

module.exports = (svg-path, pdf-path) ->
  nightmare = Nightmare!

  nightmare
  .goto file-url svg-path
  .pdf pdf-path, do
    margin-type: 1
    page-size:
      width: 420000
      height: 594000
      print-background: false
      landscape: false
  .end!
