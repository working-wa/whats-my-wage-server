# External Dependencies
bodyParser = require 'body-parser'
debug = require('debug')('minimum-wage-service')
express = require 'express'

# Internal Dependencies
models = require './models'
api_routes = require './routes'

# Initialize express server
app = express()

# Set Port Property
app.set 'port', process.env.PORT ? 3000

# Add JSON Body Parser Middleware
app.use bodyParser.json()
app.use bodyParser.urlencoded()

app.use '/', express.static("www/app/www")
app.use '/report', express.static("www/report")

# Add routes for attendance service api
app.use '/api/v1', api_routes

# Synchronize with database
models.sequelize.sync().then () ->

  # Make server start listening on the port
  server = app.listen app.get('port'), () ->
    host = server.address().address
    port = server.address().port

    debug("INFO", "Minimum wage service listening at http://#{host}/#{port}")

module.exports = app
