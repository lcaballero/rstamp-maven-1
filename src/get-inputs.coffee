path = require('path')
qu   = require('inquirer')
gen  = require('./generator')


questions = (conf) ->
  conf      ?= {}
  currDir    = path.basename(process.cwd())
  required   = (name) -> (input) ->
    if input? and input.trim().length then true
    else "A #{name} is required."

  [
    {
      name    : "target"
      type    : "input"
      message : "Where would you like to write the project?"
      default : '.'
    }
    {
      name      : "package"
      type      : "input"
      message   : "What would you like to name the base package?"
      validate  : required('package name')
    }
    {
      name      : "groupId"
      type      : "input"
      message   : "What would you like to name the groupId?"
      default   : currDir
      validate  : required('groupID')
    }
    {
      name      : "artifactId"
      type      : "input"
      message   : "What would you like to name the artifactId?  This will result in artifaceId-version.jar."
      default   : currDir
      validate  : required('artifactId')
    }
    {
      name      : 'version'
      type      : 'input'
      message   : 'What version would you like to use for this tool?'
      default   : '1.0-SNAPSHOT'
      validate  : required('version')
    }
  ]


module.exports = (rstampConf) ->
  qu.prompt(questions(rstampConf or {}), (answers) ->
    answers.source = path.resolve(__dirname, "../files/sources/s1")
    gen(answers)()
  )

