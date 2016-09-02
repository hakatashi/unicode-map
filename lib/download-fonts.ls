require! {
  path
  download
  './util': {log}
  'mz/fs'
  'mkdirp-then': mkdirp
}

fonts =
  'Symbola': 'http://users.teilar.gr/~g1951d/Symbola.zip'
  'Noto': 'https://noto-website.storage.googleapis.com/pkgs/Noto-unhinted.zip'
  'IPAexm': 'http://ipafont.ipa.go.jp/old/ipaexfont/ipaexm00201.php'
  'IPAmjm': 'http://dl.mojikiban.ipa.go.jp/IPAmjMincho/ipamjm00401.zip'
  'hanazono': 'http://jaist.dl.osdn.jp/hanazono-font/64385/hanazono-20160201.zip'
  'LibreBaskerville': 'http://www.impallari.com/media/uploads/prosources/update-86-source.zip'
  'Doulos': 'http://software.sil.org/downloads/doulos/DoulosSIL-5.000.zip'

module.exports = ->
  Promise.all do
    for let directory, url of fonts
      path-name = path.join \fonts directory
      fs.stat path-name
      .then ->
        log "#directory is already downloaded."
      .catch ->
        log "#path-name not exists. Downloading..."

        mkdirp path-name
        .then ->
          download url, path-name, {+extract}
