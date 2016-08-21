require! {
  path
  download
  'mz/fs'
  'mkdirp-then': mkdirp
}

fonts =
  'Symbola': 'http://users.teilar.gr/~g1951d/Symbola.zip'
  'Noto': 'https://noto-website.storage.googleapis.com/pkgs/Noto-unhinted.zip'

module.exports = ->
  Promise.all do
    for directory, url of fonts
      path-name = path.join \fonts directory
      fs.stat path-name
      .catch ->
        console.log "#path-name not exists. Downloading..."

        mkdirp path-name
        .then ->
          download url, path-name, {+extract}
