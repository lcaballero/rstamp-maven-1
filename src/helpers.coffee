path = require('path')


module.exports =
  packageDir : (name) ->
    (name or "").replace(/^\//, "").split(".").join("/")

  jarFile : (opts, mvnTarget = 'target') ->
    { target, groupId, version } = (opts or {})
    path.resolve(target, mvnTarget, "#{groupId}-#{version}.jar")
