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
  'Manjari': 'https://smc.org.in/downloads/fonts/manjari/Manjari.zip'
  'tlwg': 'https://linux.thai.net/pub/thailinux/software/fonts-tlwg/fonts/ttf-tlwg-0.5.0.tar.gz'
  'Jomolhari': 'https://sites.google.com/site/chrisfynn2/jomolhari-alpha003c.zip?attredirects=0'
  'Padauk': 'http://software.sil.org/downloads/d/padauk/padauk-3.002.zip'
  'Quivira': 'http://www.quivira-font.com/files/Quivira.otf'
  'UnFonts': 'https://kldp.net/unfonts/release/2607-un-fonts-core-1.0.2-080608.tar.gz'
  'Abyssinica': 'http://software.sil.org/downloads/d/abyssinica/AbyssinicaSIL-1.500.zip'
  'NotoSansCherokee': 'https://github.com/googlei18n/noto-fonts/raw/master/alpha/from-pipeline/unhinted/NotoSansCherokee-Regular.ttf'
  'MongolianScript': 'http://font.bolorsoft.com/download/fonts.zip'
  'Namdhinggo': 'http://scripts.sil.org/cms/scripts/render_download.php?format=file&media_id=NamdhinggoSIL1.004&filename=NamdhinggoSIL1.004.zip'
  'DaiBanna': 'http://scripts.sil.org/cms/scripts/render_download.php?format=file&media_id=DaiBanna-2.200.zip&filename=DaiBanna-2.200.zip'
  'Nishiki': 'http://hwm3.gyao.ne.jp/shiroi-niwatori/nishiki-teki_3_00.zip'
  'Mingzat': 'http://scripts.sil.org/cms/scripts/render_download.php?format=file&media_id=Mingzat-0.100&filename=Mingzat-0.100.zip'
  'PonomarUnicode': 'http://www.ponomar.net/files/PonomarUnicode.zip'
  'junicode': 'https://sourceforge.net/projects/junicode/files/junicode/junicode-0-7-8/junicode-0-7-8.zip'

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

          extract =
            if directory in <[Quivira NotoSansCherokee]>
              false
            else
              true

          download url, path-name, {extract, headers}
