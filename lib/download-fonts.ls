require! {
  path
  download
  './util': {log, now}
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
  'Doulos': 'http://scripts.sil.org/cms/scripts/render_download.php?format=file&media_id=DoulosSIL-5.000.zip&filename=DoulosSIL-5.000.zip'
  'OpenSans': 'http://www.opensans.com/download/open-sans.zip'
  'DejaVu': 'http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.zip'
  'FreeFont': 'https://ftp.gnu.org/gnu/freefont/freefont-ttf-20120503.zip'
  'Hancom': 'http://cdn.hancom.com/pds/docs/HancomFont.zip'
  'Scheherazade': 'http://software.sil.org/downloads/d/scheherazade/Scheherazade-2.100.zip'
  'Annapurna': 'http://software.sil.org/downloads/d/annapurna/AnnapurnaSIL-1.201.zip'

module.exports = ->
  Promise.all do
    for let directory, url of fonts
      path-name = path.join \fonts directory

      now ->
        fs.readdir path-name
      .then (files) ->
        return Promise.reject! if files.length is 0
        log "#directory is already downloaded."
      .catch ->
        log "#path-name not exists. Downloading..."

        mkdirp path-name
        .then ->
          headers =
            if directory is 'Hancom'
              {referer: 'http://www.hancom.com/'}
            else
              {}
          download url, path-name, {+extract, headers}
