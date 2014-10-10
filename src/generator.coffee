Gen             = require('rubber-stamp')
path            = require('path')
fs              = require('fs')

{ packageDir, jarFile }  = require('./helpers')


module.exports = (opts, isTesting) ->
  { source, target } = opts

  pkg = packageDir(opts.package)
  jar = jarFile(opts)

  gen = Gen.using(source, target, opts, "Generates a Java + Maven project")
    .mkdir()
    .mkdirs("src/main/java/#{pkg}")
    .mkdirs("src/test/java/#{pkg}")
    .translate('pom.xml.ftl', 'pom.xml')
    .copy('license')
    .copy('readme.md')
    .copy('readme.md')
    .translate('src/main/java/Main.java',     "src/main/java/#{pkg}/Main.java")
    .translate('src/main/java/App.java',      "src/main/java/#{pkg}/App.java")
    .translate('src/test/java/AppTest.java',  "src/test/java/#{pkg}/AppTest.java")
    .translate('gitignore',  ".gitignore")
    .run(
      options:
        cwd : path.resolve(target)
      commands:
        if isTesting then []
        else [
          { name: 'mvn'   , args: [ 'package' ] }
          { name: 'java'  , args: [ '-jar', jar ] }
          { name: 'git'   , args: [ 'init' ] }
        ]
    )

  ->
    nogen = path.resolve(opts.target, ".rstamp.nogen")

    if fs.existsSync(nogen)
      console.log("#{nogen} file is present in target directory.")
      console.log("Aborting generation.")
    else
      gen.apply()
