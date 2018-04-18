require! {
  path
  download
  './util': {log, now}
  'mz/fs'
  'mkdirp-then': mkdirp
  bluebird: Promise
}

fonts =
  'Symbola': 'https://www.wfonts.com/download/data/2016/04/23/symbola/symbola.zip'
  'Noto': 'https://noto-website.storage.googleapis.com/pkgs/Noto-unhinted.zip'
  'IPAexm': 'http://ipafont.ipa.go.jp/old/ipaexfont/ipaexm00201.php'
  'IPAmjm': 'http://dl.mojikiban.ipa.go.jp/IPAmjMincho/ipamjm00401.zip'
  'hanazono': 'http://jaist.dl.osdn.jp/hanazono-font/64385/hanazono-20160201.zip'
  'Doulos': 'https://software.sil.org/downloads/r/doulos/DoulosSIL-5.000.zip'
  'FreeFont': 'https://ftp.gnu.org/gnu/freefont/freefont-ttf-20120503.zip'
  'Hancom': 'http://cdn.hancom.com/pds/docs/HancomFont.zip'
  'Scheherazade': 'http://software.sil.org/downloads/r/scheherazade/Scheherazade-2.100.zip'
  'Annapurna': 'http://software.sil.org/downloads/r/annapurna/AnnapurnaSIL-1.202.zip'
  'Manjari': 'http://www.malayalamtype.com/fonts/Manjari-Regular.ttf'
  'tlwg': 'https://linux.thai.net/pub/thailinux/software/fonts-tlwg/fonts/ttf-tlwg-0.5.0.tar.gz'
  'Jomolhari': 'https://sites.google.com/site/chrisfynn2/jomolhari-alpha003c.zip?attredirects=0'
  'Padauk': 'http://software.sil.org/downloads/r/padauk/padauk-3.002.zip'
  'Quivira': 'http://www.quivira-font.com/files/Quivira.otf'
  'UnFonts': 'http://ftp.jaist.ac.jp/pub/Linux/Momonga/development/source/SOURCES/2607-un-fonts-core-1.0.2-080608.tar.gz'
  'Abyssinica': 'http://software.sil.org/downloads/r/abyssinica/AbyssinicaSIL-1.500.zip'
  'NotoSansCherokee': 'https://github.com/googlei18n/noto-fonts-alpha/raw/master/from-pipeline/unhinted/ttf/sans/NotoSansCherokee/NotoSansCherokee-Regular.ttf'
  'MongolianScript': 'http://font.bolorsoft.com/download/fonts.zip'
  'Namdhinggo': 'http://scripts.sil.org/cms/scripts/render_download.php?format=file&media_id=NamdhinggoSIL1.004&filename=NamdhinggoSIL1.004.zip'
  'DaiBanna': 'http://scripts.sil.org/cms/scripts/render_download.php?format=file&media_id=DaiBanna-2.200.zip&filename=DaiBanna-2.200.zip'
  'Nishiki': 'http://hwm3.gyao.ne.jp/shiroi-niwatori/nishiki-teki.zip'
  'Mingzat': 'http://scripts.sil.org/cms/scripts/render_download.php?format=file&media_id=Mingzat-0.100&filename=Mingzat-0.100.zip'
  'PonomarUnicode': 'http://www.ponomar.net/files/PonomarUnicode.zip'
  'junicode': 'https://sourceforge.net/projects/junicode/files/junicode/junicode-0-7-8/junicode-0-7-8.zip'
  'BTC': 'https://en.bitcoin.it/BTC.ttf'
  'ObserverSymbol': 'http://hypertexthero.com/static/img/observer-symbol/observer-symbol-latest.zip'
  'Analecta': 'https://www.wfonts.com/download/data/2016/06/09/analecta/analecta.zip'
  'BabelStoneHan': 'http://www.babelstone.co.uk/Fonts/Download/BabelStoneHan.zip'
  'OpenSans': 'http://www.opensans.com/download/open-sans.zip'
  'DejaVu': 'https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.zip'
  'JGLao': 'https://github.com/hakatashi/font-archive/raw/master/jglao.zip'
  'NotoSerifCJKjp': 'https://noto-website.storage.googleapis.com/pkgs/NotoSerifCJKjp-hinted.zip'
  'LisuUnicode': 'https://github.com/phjamr/LisuUnicode/raw/master/LisuUnicode-Regular.ttf'
  'Wakor': 'http://www.evertype.com/fonts/vai/wakorfont.zip'
  'Charis': 'https://software.sil.org/downloads/r/charis/CharisSIL-5.000.zip'
  'BabelStonePhagsPa': 'http://www.babelstone.co.uk/Fonts/Download/BabelStonePhagspaBook_v2.ttf'
  'Pagul': 'https://sourceforge.net/projects/pagul/files/Pagul_v1.0.zip'
  'TaiHeritage': 'https://software.sil.org/downloads/r/taiheritage/TaiHeritagePro-2.600.zip'

module.exports = ->
  Promise.each do
    * Object.keys fonts
    * (directory) ->
        url = fonts[directory]
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
              else if directory in <[Namdhinggo DaiBanna Mingzat]>
                {accept: '*/*'}
              else
                {}

            extract =
              if directory in <[Quivira NotoSansCherokee BTC Manjari LisuUnicode BabelStonePhagsPa]>
                false
              else
                true

            download url, path-name, {extract, headers}
