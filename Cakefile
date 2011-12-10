{print}    = require 'sys'
{exec}     = require 'child_process'
{spawn}    = require 'child_process'
fs         = require 'fs'
path_utils = require 'path'

#==========================================================
# Utilities (todo: move in a new file)
#==========================================================

# Wait
wait = ->


# Copy one file
copy = (from, to) ->
  fs.readFile from, (err, data) ->
    throw err if err
    fs.writeFile to, data


# Copy multiple files
copyAll = (from, to) ->
  if (!path_utils.existsSync(from))
    throw "DirectoryNotFound"

  fs.readdir from, (err, files) ->
    throw err if err

    for f in files
      copy("#{from}/#{f}", "#{to}/#{f}")


# Create a directory if it doesn't exists (recursive)
createDirectory = (path) -> 
  sub_paths = path.split('/')

  path_to_create = ""

  for p in sub_paths
    path_to_create += "#{p}/"

    if (!path_utils.existsSync(path_to_create))
      fs.mkdirSync(path_to_create, '711')


# Get a list of files paths from a directory (recursive)
# Usage: getFilesSync('path/to/folder', 'coffee$', '^interface')
getFilesSync = (from, includes, excludes, results) ->
  if (!path_utils.existsSync(from))
    throw "DirectoryNotFound"
  
  results ?= new Array
  
  files = fs.readdirSync(from)
  
  for name in files
    path = "#{from}/#{name}"
    stats = fs.statSync(path)
    results.push(path) if stats.isFile() and name.match(includes)? and !name.match(excludes)?
    getFilesSync(path, includes, excludes, results) if stats.isDirectory()
  
  return results


# Merge multiple files from a directory (recursive)
merge = (from, to) ->
  files = getFilesSync(from, 'coffee$', '^interface')

  #for f in files
  #  print "#{f}\n"

  datas = new Array()
  
  for file in files
    datas.push(fs.readFileSync(file))
  
  fs.writeFileSync(to, datas.join('\n\n'))


# Merge one file into another file
mergeOne = (from, into) ->
  datas = [fs.readFileSync(into), fs.readFileSync(from)]
  fs.writeFileSync(into, datas.join('\n\n'))


# Compile
compile = (from, to, name) ->
  path = "#{to}/#{name}.coffee"
  done = false

  # build & delete the merged file
  exec "coffee -c -o #{to} #{path}", (err) ->
    if (err)
      done = true
      throw err

    fs.unlinkSync(path)
    done = true

  #wait for async method to terminate
  #wait() until done


# Merge and compile files from a directory (recursive)
# Usage: mergeAndCompile('path/from', 'path/to', 'myscript')
mergeAndCompile = (from, to, name) ->
  path = "#{to}/#{name}.coffee"

  merge(from, path)

  # build & delete the merged file
  exec "coffee -c -o #{to} #{path}", (err) ->
    throw err if err
    fs.unlink path


#==========================================================
# Tasks
#==========================================================

# Options
option '-p', '--path [DIR]', 'path of the game'
option '-n', '--name [NAME]', 'name of the whatever'


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
    options.path + '/assets',
  ]

  for path in paths
    fs.mkdirSync(path, '711')

  copy('scaffolding/Cakefile', "#{options.path}/Cakefile")
  copy('scaffolding/src/game.coffee', "#{options.path}/src/game.coffee")

  copyAll('bin/debug', "#{options.path}/lib")


# Task: build
task 'build', 'Build project', ->
  createDirectory('bin/js')

  exec 'coffee -c -o bin/js src', (err) ->
    throw err if err   


# Task: watch
task 'watch', 'Watch project for changes', ->
  createDirectory('bin/js')

  exec 'coffee -w -c -o bin/js src', (err) ->
    throw err if err


# Task: debug
task 'debug', 'Build project in one file for debug', ->

  # create dirs
  createDirectory('bin/debug')

  # merge and compile the src dir
  merge('src', 'bin/debug/fungus.coffee')
  mergeOne('src/interface.coffee', 'bin/debug/fungus.coffee')
  compile('bin/debug', 'bin/debug', 'fungus')

  # copy stuff
  copyAll('lib', 'bin/debug')


# Task: build examples
task 'examples', 'Build the examples', ->
  invoke 'debug'

  directories = fs.readdirSync('examples')
  
  for d in directories
    example_directory = 'examples/' + d
    example_directory_bin = example_directory + '/bin'

    # create bin directory
    createDirectory(example_directory_bin)
    createDirectory("#{example_directory_bin}/assets")

    # merge the files
    mergeAndCompile("#{example_directory}/src", example_directory_bin, 'game')
    
    # copy everything from debug
    copyAll('bin/debug', example_directory_bin)

    # copy everything from assets
    try
      copyAll("#{example_directory}/assets", "#{example_directory_bin}/assets")
    catch error
      # the assets directory doesn't exist for this example


# Task: launch an example
task 'show_example', 'Show an example', (options) ->
  invoke 'examples'

  if (!options.name?)
    throw 'syntax: cake -n name_of_example show_example'


  p = spawn 'python', ['-m', 'SimpleHTTPServer'], {
    cwd: "#{process.cwd()}/examples/#{options.name}/bin",
    env: process.env,
    customFds: [-1, -1, -1]
  }

  p.stdout.on 'data', (data) ->
    print "stdout: #{data}"

  p.stderr.on 'data', (data) ->
    print "stderr: #{data}"

  p.on 'exit', (code) ->
    print "exit: #{code}"

