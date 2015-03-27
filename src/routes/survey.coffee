# External Dependencies
debug = require('debug')('minimum-wage-service')
express = require 'express'
moment = require 'moment'

questions = require '../data/questions.json'

# Express Components
router = express.Router()

router.all "*", (req, res, next) ->
  debug "In Survey router"
  next()

router.get '/question', (req, res) ->
  res.json(questions).end()

module.exports = router
