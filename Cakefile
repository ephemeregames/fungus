{print} = require 'sys'
{exec}  = require 'child_process'
fs      = require 'fs'

# Utility: copy file
copy = (from, to) ->
  fs.readFile from, (err, data) ->
    throw err if err
    fs.writeFile to, data


# Options
option '-p', '--path [DIR]', 'path of the game'

# Task: create a new game
task 'new', 'Create a new game', (options) ->

  if (!options.path?)
    throw 'you must provide a path where the game will be created'

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

  #copy('scaffolding/Cakefile', options.path)
  #copy('scaffolding/resources/index.html', options.path + '/resources/index.html')
  #copy('scaffolding/src/game.coffee', options.path + '/src/game.coffee')


# TASK: SIMPLE BUILD

task 'build', 'Build project', ->
  exec 'coffee -c -o js src', (err) ->
    throw err if err   


# TASK: WATCH DIRECTORY

task 'watch', 'Watch project for changes', ->
  exec 'coffee -w -c -o js src', (err) ->
    throw err if err


# TASK: JOIN FILES. TO DO: better than that.
task 'debug', 'Build project in one file for debug', ->
  # omit src/ and .coffee to make the below lines a little shorter
  files  = [
    'utilities/extends',
    'utilities/timer',
    'utilities/random',
    'visual/text',
    'visual/canvas2D',
    'visual/canvas3D',
    'visual/scene',
    'visual/scenes',
    'game/fungus',
  ]

  output = 'release/fungus.coffee'
  jquery = 'jquery-1.7.1.min.js'
  three  = 'Three.js'

  datas = new Array
  remaining = files.length

  # todo create dir

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
  copy("lib/#{jquery}", "release/#{jquery}")
  copy("lib/#{three}", "release/#{three}")
  copy("src/html/index.html", "release/index.html")
  #copy("src/html/style.css", "release/style.css")
