vm = require "vm"
Mincer = require "mincer"
environment = new Mincer.Environment()
environment.appendPath("./source/js")
source = environment.findAsset("application.js")
application = vm.createScript(source.toString())

chai = require "chai"
chai.expect()

beforeEach ->
  root.expect = chai.expect
  root.window = root
  root.document = { addEventListener: -> }
  application.runInThisContext()
