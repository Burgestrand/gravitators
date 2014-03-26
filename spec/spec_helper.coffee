fs = require "fs"
vm = require "vm"
Mincer = require "mincer"
environment = new Mincer.Environment()
environment.appendPath("#{__dirname}/../source/js")
source = environment.findAsset("application.js").toString()

compiledSourcePath = "#{__dirname}/application.jsc"
application = vm.createScript(source, compiledSourcePath)
fs.writeFileSync(compiledSourcePath, source)

chai = require "chai"
chai.expect()

beforeEach ->
  root.expect = chai.expect
  root.window = root
  root.document = { addEventListener: -> }
  application.runInThisContext()
