require! {
  path
  'mz/fs'
  'yaml-js'
  './util': {log, merge-maps}
  './codepoint-builder'
}

module.exports = ->
  fs.readdir 'data/codepoints'
  .then (files) ->
    yaml-files = files.filter -> it.slice -4 is '.yml'

    Promise.all yaml-files.map (yaml-file) ->
      fs.read-file path.resolve 'data/codepoints' yaml-file
      .then (yaml) ->
        object = yaml-js.load yaml

        codepoint-builder object

  .then (codepoint-maps) ->
    merge-maps codepoint-maps
