# External Dependencies
debug = require('debug')('minimum-wage-service')
express = require 'express'
moment = require 'moment'

questions = require '../data/questions.json'
notes = require '../data/notes.json'

# Express Components
router = express.Router()

router.all "*", (req, res, next) ->
  debug "In Survey router"
  next()

router.get '/question', (req, res) ->
  res.json(questions).end()

router.get '/note', (req, res) ->
  res.json(notes).end()

module.exports = router
