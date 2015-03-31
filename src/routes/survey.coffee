# External Dependencies
debug = require('debug')('minimum-wage-service')
express = require 'express'
moment = require 'moment'
require 'twix'

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

# A = Schedule 1 employers (more than 500 employees in the U.S.)
# B = Schedule 1 employers (more than 500 emp1loyees in the U.S.) with medical benefits
# C = Schedule 2 employers (500 or fewer employees in the U.S.) with minimum compensation
# D = Schedule 2 employers (500 or fewer employees in the U.S.)
wageSchedules = {
  "A": [
    {"wage": 9.47, "time_range": {start: "2014-01-01", end: "2015-03-27"}},
    {"wage": 11.0, "time_range": {start: "2015-03-28", end: "2015-12-31"}},
    {"wage": 13.0, "time_range": {start: "2016-01-01", end: "2016-12-31"}},
    {"wage": 15.0, "time_range": {start: "2017-01-01", end: "2018-12-31"}}
  ],
  "B": [
    {"wage": 9.47, "time_range": {start: "2014-01-01", end: "2015-03-27"}},
    {"wage": 11.0, "time_range": {start: "2015-03-28", end: "2015-12-31"}},
    {"wage": 12.5, "time_range": {start: "2016-01-01", end: "2016-12-31"}},
    {"wage": 13.5, "time_range": {start: "2017-01-01", end: "2017-12-31"}},
    {"wage": 15.0, "time_range": {start: "2018-01-01", end: "2018-12-31"}}
  ],
  "C": [
    {"wage": 9.47, "time_range": {start: "2014-01-01", end: "2015-03-27"}},
    {"wage": 11.0, "time_range": {start: "2015-03-28", end: "2015-12-31"}},
    {"wage": 12.0, "time_range": {start: "2016-01-01", end: "2016-12-31"}},
    {"wage": 13.0, "time_range": {start: "2017-01-01", end: "2017-12-31"}},
    {"wage": 14.0, "time_range": {start: "2018-01-01", end: "2018-12-31"}},
    {"wage": 15.0, "time_range": {start: "2019-01-01", end: "2019-12-31"}}
  ],
  "D": [
    {"wage": 9.47, "time_range": {start: "2014-01-01", end: "2015-03-27"}},
    {"wage": 10.0, "time_range": {start: "2015-03-28", end: "2015-12-31"}},
    {"wage": 10.5, "time_range": {start: "2016-01-01", end: "2016-12-31"}},
    {"wage": 11.0, "time_range": {start: "2017-01-01", end: "2017-12-31"}},
    {"wage": 11.5, "time_range": {start: "2018-01-01", end: "2018-12-31"}},
    {"wage": 12.0, "time_range": {start: "2019-01-01", end: "2019-12-31"}},
    {"wage": 13.5, "time_range": {start: "2020-01-01", end: "2020-12-31"}},
    {"wage": 15.0, "time_range": {start: "2021-01-01", end: "2021-12-31"}}
  ],
  "Washington State": [
    {"wage":9.47,"time_range": {start: "2015-01-01", end: "2115-12-31"}} 
  ]
}

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

  debug "Schedule: #{schedule}"
  debug "Schedule: #{wageSchedules[schedule]}"

  for current, i in wageSchedules[schedule]
    debug "Current: #{JSON.stringify current}"

    if schedule == "D"
      compensation = wageSchedules["C"][i]

      if compensation?
        current.compensation = compensation.wage

    if !current.time_range.isPast()
      intervals.push(current)


  result.intervals = intervals

  res.json(result).end()


module.exports = router
