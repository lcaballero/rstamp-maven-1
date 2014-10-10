Gen             = require('../src/generator')
path            = require('path')
fs              = require('fs')
{ run }         = require('./ProcessHelpers')
{ packageDir }  = require('../src/helpers')


describe 'GeneratorTests =>', ->

  exists = (root, dirs...) ->
    for dir in dirs
      file = path.resolve(root, dir)
      expect(fs.existsSync(file), 'should have created file: ' + file).to.be.true

  rm = (cwd, t, cb) ->
    cmds =
      target : cwd
      commands: [ { name: 'rm', args: ['-rf', t] } ]
    run(cmds, cb)

  describe 'generate', ->

    source          = 'files/sources/s1'
    target          = 'files/targets/t1'
    name            = 'new-test-project'
    pkg             = 'first.pkg'
    groupId         = 'my.latest.namespace'
    artifactId      = 'NextProject'
    version         = '0.0.1'
    pkgDir          = null
    pom             = null

    beforeEach ->
      Gen(
        package         : pkg
        source          : source
        target          : target
        projectName     : name
        groupId         : groupId
        artifactId      : artifactId
        version         : version
      , true)()

      pkgDir  = packageDir(pkg)
      pom     = fs.readFileSync(path.resolve(target, 'pom.xml'), 'utf8').toString()


    afterEach (done) ->
#      done()
      rm('files/targets/', 't1', done)

    it 'check setup', ->
      expect(pkgDir, 'pkgDir should exist').to.exist
      expect(pom, 'pom content should have been read').to.exist

    it 'should have created root dir', ->
      exists('files/targets', 't1')

    it 'should have created directories in src', ->
      exists(target, "src/main/", 'src/main/java')
      exists(target, 'src/test/', 'src/test/java')

    it 'should have created package directories in src', ->
      exists(target, "src/main/java/#{pkgDir}")
      exists(target, "src/test/java/#{pkgDir}")

    it 'should have copied the root files', ->
      exists(target, 'license', 'pom.xml', 'readme.md')

    it 'should have translated pom.xml.ftl and replaced all <% and %>', ->
      hasOpen  = /<%/g.test(pom)
      hasClose = /%>/g.test(pom)
      expect(hasOpen).to.be.false
      expect(hasClose).to.be.false

    it 'should have replace templating with values', ->
      expect(_.contains(pom, pkg)).to.be.true
      expect(_.contains(pom, groupId)).to.be.true
      expect(_.contains(pom, artifactId)).to.be.true
      expect(_.contains(pom, version)).to.be.true
      expect(_.contains(pom, pkg + ".Main")).to.be.true




