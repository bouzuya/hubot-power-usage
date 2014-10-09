# hubot-power-usage

A Hubot script that show power usage

![](http://img.f.hatena.ne.jp/images/fotolife/b/bouzuya/20141010/20141010000948.gif)

## Installation

    $ npm install git://github.com/bouzuya/hubot-power-usage.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-power-usage.git#TAG'

## Example

    bouzuya> hubot help power-usage
      hubot> hubot power-usage <hokkaido|tohoku|tokyo|chubu|kansai|kyushu> - show power usage

    bouzuya> hubot power-usage kansai
      hubot> kansai 2014-10-09 22:00 15260000 kW / 22350000 kW (68%)

## Configuration

See [`src/scripts/power-usage.coffee`](src/scripts/power-usage.coffee).

## Development

`npm run`

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][mail]&gt; ([http://bouzuya.net][url])

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]
[![Coverage Status][coveralls-badge]][coveralls]

[travis]: https://travis-ci.org/bouzuya/hubot-power-usage
[travis-badge]: https://travis-ci.org/bouzuya/hubot-power-usage.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-power-usage
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-power-usage.png
[coveralls]: https://coveralls.io/r/bouzuya/hubot-power-usage
[coveralls-badge]: https://img.shields.io/coveralls/bouzuya/hubot-power-usage.svg
[user]: https://github.com/bouzuya
[mail]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
