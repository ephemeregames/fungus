{print} = require 'sys'
{exec}  = require 'child_process'
fs      = require 'fs'
path    = require 'path'

jquery  = 'jquery-1.7.1.min.js'
three   = 'Three.js'


# Utility: copy one file
copy = (from, to) ->
  fs.readFile from, (err, data) ->
    throw err if err
    fs.writeFile to, data


# Utility: copy multiple files
copyAll = (from, to) ->
  fs.readdir from, (err, files) ->
    throw err if err

    for f in files
      copy("#{from}/#{f}", "#{to}/#{f}")


# Utility: create a directory if it doesn't exists
createDirectory = (p) ->
  if (!path.existsSync(p))
    fs.mkdirSync(p, '711')


# Options
option '-p', '--path [DIR]', 'path of the game'


# Task: create a new game
task 'new', 'Create a new game', (options) ->

  if (!options.path?)
    throw 'syntax: cake -p path/to/your/game new'

  paths = [
    options.path,
    options.path + '/bin',
    options.path + '/bin/debug',
    options.path + '/bin/release',
    options.path + '/lib',
    options.path + '/src',
    options.path + '/resources',
  ]

  for path in paths
    fs.mkdirSync(path, '711')

  copy('scaffolding/Cakefile', options.path + '/Cakefile')
  copy('scaffolding/resources/index.html', options.path + '/resources/index.html')
  copy('scaffolding/src/game.coffee', options.path + '/src/game.coffee')

  copyAll('bin/debug', options.path + '/lib')


# Task: build
task 'build', 'Build project', ->
  createDirectory('bin')
  createDirectory('bin/js')

  exec 'coffee -c -o bin/js src', (err) ->
    throw err if err   


# Task: watch
task 'watch', 'Watch project for changes', ->
  createDirectory('bin')
  createDirectory('bin/js')

  exec 'coffee -w -c -o bin/js src', (err) ->
    throw err if err


# Task: debug
task 'debug', 'Build project in one file for debug', ->
  # omit src/ and .coffee to make the below lines a little shorter
  files  = [
    'utilities/extends',
    'utilities/timer',
    'utilities/random',
    'utilities/fatal',
    'visual/text',
    'visual/canvas2D',
    'visual/canvas3D',
    'visual/scene',
    'visual/scenes',
    'game/game',
    'game/launcher',
    'interface'
  ]

  output = 'bin/debug/fungus.coffee'

  datas = new Array
  remaining = files.length

  # create dirs
  createDirectory('bin')
  createDirectory('bin/debug')

  # merge the files
  for file, index in files then do (file, index) ->
    fs.readFile "src/#{file}.coffee", (err, data) ->
      throw err if err
      datas[index] = data
      process() if --remaining is 0

  process = ->
    fs.writeFile output, datas.join('\n\n'), (err) ->
      throw err if err

      exec "coffee -c #{output}", (err) ->
        throw err if err
        fs.unlink output

  # copy stuff
  copy("lib/#{jquery}", "bin/debug/#{jquery}")
  copy("lib/#{three}", "bin/debug/#{three}")
