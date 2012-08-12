{print}    = require 'sys'
{spawn}    = require 'child_process'
fs         = require 'fs'
execSync   = require 'exec-sync'

#==========================================================
# Utilities
#==========================================================

# Wait for x milliseconds
wait = (ms) ->
  setTimeout(->,
  ms)

# Copy one file
copy = (from, to) ->
  fs.writeFileSync(to, fs.readFileSync(from))


# Copy multiple files
copyAll = (from, to) ->
  throw 'DirectoryNotFound' unless fs.existsSync(from)

  files = fs.readdirSync(from)

  for f in files
    stats = fs.statSync("#{from}/#{f}")

    if stats.isDirectory()
      createDirectory("#{to}/#{f}")
      copyAll("#{from}/#{f}", "#{to}/#{f}")
    else
      copy("#{from}/#{f}", "#{to}/#{f}")


# Remove a directory (recursive)
removeDirectory = (path) ->
  return unless fs.existsSync(path)

  # get all the directories and files within path
  data = fs.readdirSync(path)
  directories = []
  files = []

  for d in data
    sub_path = "#{path}/#{d}"

    if fs.statSync(sub_path).isDirectory()
      directories.push(sub_path)
    else
      files.push(sub_path)

  # for each directory, repeat the process so far
  for d in directories
    removeDirectory(d)

  # at this point, we have enumerated each file and directory
  # and the bottom of the directory hierarchy starts processing

  # remove each file in the directory
  for f in files
    fs.unlinkSync(f)
 
  # remove the empty directory
  fs.rmdirSync(path)


# Create a directory if it doesn't exists (recursive)
createDirectory = (path) -> 
  sub_paths = path.split('/')

  path_to_create = ""

  for p in sub_paths
    path_to_create += "#{p}/"

    unless fs.existsSync(path_to_create)
      fs.mkdirSync(path_to_create, '711')


# Reset a directory, which means:
# - Remove and recreate the directory if presents
# - Create the directory if not
resetDirectory = (path) ->
  removeDirectory(path)
  createDirectory(path)


# Get a list of files paths from a directory (recursive)
# Usage: getFilesSync('path/to/folder', 'coffee$', '^interface')
getFilesSync = (from, includes, excludes, results) ->
  throw 'DirectoryNotFound' unless fs.existsSync(from)
  
  results ?= new Array
  
  files = fs.readdirSync(from)
  
  for name in files
    path = "#{from}/#{name}"
    stats = fs.statSync(path)
    results.push(path) if stats.isFile() and name.match(includes)? and !name.match(excludes)?
    getFilesSync(path, includes, excludes, results) if stats.isDirectory()
  
  return results


# Merge multiple files from a directory (recursive)
# TODO remove 'interface' dependence
merge = (from, to) ->
  files = getFilesSync(from, 'coffee$', '^interface')

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

  # build
  execSync("coffee -c -o #{to} #{path}")

  # delete the merged file
  fs.unlinkSync(path)


# Merge and compile files from a directory (recursive)
# Usage: mergeAndCompile('path/from', 'path/to', 'myscript')
mergeAndCompile = (from, to, name) ->
  path = "#{to}/#{name}.coffee"

  merge(from, path)

  # build & delete the merged file
  execSync("coffee -c -o #{to} #{path}")

  fs.unlink path


#==========================================================
# Tasks
#==========================================================

# Options
option '-p', '--path [DIR]', 'path of the game'
option '-n', '--name [NAME]', 'name of the whatever'


# Task: create a new game
task 'new', 'Create a new game', (options) ->
  unless options.path?
    console.log('syntax: cake -p path/to/your/game new')
    return

  debug()

  # create the paths
  paths = [
    '/lib',
    '/src',
    '/assets',
    '/node_modules'
  ].map (sub_path) -> options.path + sub_path

  # create the directories with the paths
  for path in paths
    createDirectory(path)

  copy('scaffolding/Cakefile', "#{options.path}/Cakefile")
  copy('scaffolding/src/game.coffee', "#{options.path}/src/game.coffee")

  copyAll('bin/debug', "#{options.path}/lib")
  copyAll('node_modules', "#{options.path}/node_modules")


# Task: build
task 'build', 'Build project', ->
  resetDirectory('bin/js')

  execSync('coffee -c -o bin/js src')


# Task: watch
task 'watch', 'Watch project for changes', ->
  resetDirectory('bin/js')

  execSync('coffee -w -c -o bin/js src')


# Task: debug
debug = ->
  resetDirectory('bin/debug')

  # merge and compile the src dir
  merge('src', 'bin/debug/fungus.coffee')
  mergeOne('src/interface.coffee', 'bin/debug/fungus.coffee')
  compile('bin/debug', 'bin/debug', 'fungus')

  # copy stuff
  copyAll('lib', 'bin/debug')
  

task 'debug', 'Build project in one file for debug', -> debug()


# Task: build examples
examples = ->
  debug()

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

task 'examples', 'Build the examples', -> examples()


# Task: update a game with the latest version of the library
task 'update', 'Update a game with this version of the library', (options) ->
  unless options.path?
    console.log('syntax: cake -p path/to/your/game update')
    return

  debug()

  resetDirectory("#{options.path}/lib")
  resetDirectory("#{options.path}/node_modules")

  copyAll('bin/debug', "#{options.path}/lib")
  copyAll('node_modules', "#{options.path}/node_modules")


# Task: launch an example
task 'show_example', 'Show an example', (options) ->
  examples()

  unless options.name?
    console.log('syntax: cake -n name_of_example show_example')
    return


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

