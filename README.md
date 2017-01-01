# The Unicode Map Project [![Build Status][travis-image]][travis-url]

The bunch of Unicode characters in a poster, on a [Hilbert curve](https://en.wikipedia.org/wiki/Hilbert_curve).

[travis-image]: https://travis-ci.org/hakatashi/unicode-map.svg?branch=master
[travis-url]: https://travis-ci.org/hakatashi/unicode-map

![](https://i.imgur.com/7eAXxbc.jpg)

## About

**The Unicode Map Project** (Japanese: Unicode巨大地図) is an experimental project to illustrate [Unicode](http://unicode.org/standard/WhatIsUnicode.html) characters (and non-characters) in a large poster, and sell them at some [dōjinshi](https://en.wikipedia.org/wiki/D%C5%8Djinshi) fair event such as [Comiket](https://en.wikipedia.org/wiki/Comiket) in Japan. The version 1.0.0 was [sold at Comiket 91](https://webcatalog-free.circle.ms/Circle/13007447), held on Dec 29, 2016. Its composition of Unicode characters is very featured by its arrangement, which introduces a [Hilbert curve](https://en.wikipedia.org/wiki/Hilbert_curve) to visually span [the blocks of Unicode](https://en.wikipedia.org/wiki/Unicode_block).

The poster is developed with open source and the poster data [can be downloaded](#download) for free. And also any contribution is welcomed!

Currently the poster is only available with direct distribution. Though you're free to print it by DIY, we have the roadmap to the next major version of the poster and then we're planning the reprinting of the poster and sales by mail.

## Download

### BMP-1 ver1.0.0

* [SVG (24.8 MB)](https://github.com/hakatashi/unicode-map/releases/download/201701011720/poster.svg)
* [PNG (16.5 MB)](https://github.com/hakatashi/unicode-map/releases/download/201701011720/poster.png)
* [PDF (13.8 MB)](https://github.com/hakatashi/unicode-map/releases/download/201701011720/poster.pdf)

### Development version

Development version of the builds are available in the [Release page](https://github.com/hakatashi/unicode-map/releases).

## Build

Install [Node.js 6+](https://nodejs.org/) and run:

    npm install
    npm run build

**WARN: This command will download almost 1GB of the font data from the internet, and cache them into `fonts` subdirectory.**

## License

The overall repository is licensed under [GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt) by hakatashi.

The files not in the `data/glyphs` subdirectory are also licensed under [MIT License](https://opensource.org/licenses/MIT) by hakatashi.

## Roadmap

* Full support of BMP
* More permissive license

## Materials

* ArmenianEternity.svg
	* link: https://commons.wikimedia.org/wiki/File:ArmenianEternity.svg
	* author: AnonMoos
	* license: Public Domain
	* for: u058d.svg
* SYRIAC-LETTER-MALAYALAM-NGA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-NGA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0860.svg
* SYRIAC-LETTER-MALAYALAM-JA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-JA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0861.svg
* SYRIAC-LETTER-MALAYALAM-NYA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-NYA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0862.svg
* SYRIAC-LETTER-MALAYALAM-TTA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-TTA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0863.svg
* SYRIAC-LETTER-MALAYALAM-NNA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-NNA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0864.svg
* SYRIAC-LETTER-MALAYALAM-NNNA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-NNNA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0865.svg
* SYRIAC-LETTER-MALAYALAM-BHA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-BHA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0866.svg
* SYRIAC-LETTER-MALAYALAM-RA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-RA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0867.svg
* SYRIAC-LETTER-MALAYALAM-LLA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-LLA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0868.svg
* SYRIAC-LETTER-MALAYALAM-LLLA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-LLLA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u0869.svg
* SYRIAC-LETTER-MALAYALAM-SSA.png
	* link: https://en.wikipedia.org/wiki/File:SYRIAC-LETTER-MALAYALAM-SSA.png
	* author: Raamesh
	* license: CC BY-SA 4.0
	* for: u086A.svg
* Астрологічні цифри сингальського письма. Sinhalese astrological numerals (Sinhala Lith Illakkam).png
	* link: https://commons.wikimedia.org/wiki/File:%D0%90%D1%81%D1%82%D1%80%D0%BE%D0%BB%D0%BE%D0%B3%D1%96%D1%87%D0%BD%D1%96_%D1%86%D0%B8%D1%84%D1%80%D0%B8_%D1%81%D0%B8%D0%BD%D0%B3%D0%B0%D0%BB%D1%8C%D1%81%D1%8C%D0%BA%D0%BE%D0%B3%D0%BE_%D0%BF%D0%B8%D1%81%D1%8C%D0%BC%D0%B0._Sinhalese_astrological_numerals_(Sinhala_Lith_Illakkam).png
	* author: 00 وديع
	* license: CC0 1.0
	* for: u0de6.svg .. u0def.svg
* Open Sans
	* link: http://www.opensans.com/
	* author: Steve Matteson and Google Corporation
	* license: Apache License v2
	* for: Control characters
* Linux Libertine
	* link: http://www.linuxlibertine.org/
	* author: Libertine Open Fonts Project and Philipp H. Poll
	* license: SIL OFL 1.1
	* for: Poster Design
* Cinzel
	* link: http://ndiscovered.com/cinzel/
	* author: Natanael Gama
	* license: SIL OFL 1.1
	* for: Poster Design
