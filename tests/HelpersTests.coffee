helpers = require("../src/helpers")
path = require('path')
{ packageDir, jarFile } = helpers


describe 'HelpersTests =>', ->

  describe 'packageDir =>', ->

    it 'should handle falsy values', ->

    it "should remove leading '/' ", ->

    it "should produce a directory from the package name", ->
      dir = packageDir("first.pkg")
      expect(dir).to.equal('first/pkg')

  describe 'jarFile =>', ->

    it "should determine the new jar file name", ->
      opts =
        target  : "files/targets/t1"
        groupId : "TestMaven"
        version : "1.0-SNAPSHOT"
      f = jarFile(opts)

      expect(f).to.equal(path.resolve(opts.target, 'target', "#{opts.groupId}-#{opts.version}.jar"))
