# External Dependencies
debug = require('debug')('minimum-wage-service')
express = require 'express'
moment = require 'moment'
require 'twix'

questions = require '../data/questions.json'
notes = require '../data/notes.json'
wageSchedules = require '../data/wage-schedules.json'

# Express Components
router = express.Router()

router.all "*", (req, res, next) ->
  debug "In Survey router"
  next()

router.get '/question', (req, res) ->
  res.json(questions).end()

router.get '/note', (req, res) ->
  res.json(notes).end()

router.post '/wage', (req, res) ->
  {answers} = req.body
  result = {}

  if answers["work-seattle"] == "yes"
    if answers["number-employees"] == ">500" or answers["big-national-chain"] == "yes"
      if answers["medical-benefits"] == "no"
        schedule = "A"
      else
        schedule = "B"
    else
      if answers["health-insurance"] == "no" and answers["tips"] == "no"
        schedule = "C"
      else
        schedule = "D"
  else
    schedule = "Washington State"
    result.state = true

  intervals = []

  debug "Schedule Looked Up: #{schedule}"
  debug "Full Schedule: #{JSON.stringify wageSchedules[schedule]}"

  for current, i in wageSchedules[schedule]
    debug "Current: #{JSON.stringify current}"

    if schedule == "D"
      compensation = wageSchedules["C"][i]

      if compensation?
        current.compensation = compensation.wage

    if !moment(current.time_range.start).twix(current.time_range.end,{allDay: true}).isPast()
      intervals.push(current)


  result.intervals = intervals

  res.json(result).end()


module.exports = router
