sinon = require "sinon"
sourcemap = require "source-map"
fs = require "fs"
vm = require "vm"
Mincer = require "mincer"
environment = new Mincer.Environment()
environment.appendPath("#{__dirname}/../source/js")
environment.enable "source_maps"

asset = environment.findAsset("application.js")
source = asset.toString()

compiledSourcePath = "#{__dirname}/application.jsc"
application = vm.createScript(source, compiledSourcePath)
fs.writeFileSync(compiledSourcePath, source)

sourceMapRegexp = new RegExp("/([^/]+\.jsc):(\\d+):(\\d+)", "g")
sourceMaps = { "application.jsc": new sourcemap.SourceMapConsumer(asset.sourceMap) }
prepareStackTrace = Error.prepareStackTrace
Error.prepareStackTrace = (error, stack) ->
  prepareStackTrace(error, stack).replace sourceMapRegexp, (match, file, line, column) ->
    { source, line, column, name } = sourceMaps[file].originalPositionFor(line: parseInt(line), column: parseInt(column))
    "#{match} [#{source}:#{line}:#{column}]"

chai = require "chai"
chai.expect()

beforeEach ->
  root.sinon = sinon
  root.expect = chai.expect
  root.window = root
  root.document = { addEventListener: -> }
  application.runInThisContext()
