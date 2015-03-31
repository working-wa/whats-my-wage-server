# External Dependencies
debug = require('debug')('minimum-wage-service')
express = require 'express'

# Express Components
router = express.Router()


#Internal Dependencies
employer_size_router = require './employer_size'
survey_router = require './survey'

router.all '*', (req,res,next) ->
  res.header("Access-Control-Allow-Origin", "*")
  res.header("Access-Control-Allow-Headers", "Content-Type, X-Requested-With")
  next()

router.get '/wage_theft/report_info', (req, res) ->
  res.json({
    post_url: "https://docs.google.com/forms/d/12rKqdkVtQTcckc3ZyNp6AY7sZIKlj11k-QVFaAwKjCk/formResponse"
    mapping:
      "employerName": "entry.1223479717"
      "employeeName": "entry.1255459603"
      "employeeEmail": "entry.570498028"
      "employeePhone": "entry.229881285"
  }).end()

router.use '/employer_size', employer_size_router
router.use '/survey', survey_router

module.exports = router
