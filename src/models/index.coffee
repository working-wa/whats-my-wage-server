# External Dependencies
debug = require('debug')('sequelize')
config = require 'config'
Sequelize = require 'sequelize'
underscore = require 'underscore'

config.logging = debug

debug "Config: #{JSON.stringify config}"

sequelize = new Sequelize(config.database, config.username, config.password, config)

db =
  Address: sequelize.import(__dirname + "/address")
  EmployerSizeReport: sequelize.import(__dirname + "/employer_size_report")
  Employer: sequelize.import(__dirname + "/employer")

Object.keys(db).forEach (modelName) ->
  if "associate" in underscore.functions(db[modelName])
    db[modelName].associate(db)

db.sequelize = sequelize

module.exports = db

