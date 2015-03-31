# External Dependencies
debug = require('debug')('minimum-wage-service')
express = require 'express'
request = require 'request'

# Express Components
router = express.Router()


#Internal Dependencies
employer_size_router = require './employer_size'
survey_router = require './survey'

router.all '*', (req,res,next) ->
  res.header("Access-Control-Allow-Origin", "*")
  res.header("Access-Control-Allow-Headers", "Content-Type, X-Requested-With")
  next()

wageTheftReportInfo =
  post_url: "https://docs.google.com/forms/d/12rKqdkVtQTcckc3ZyNp6AY7sZIKlj11k-QVFaAwKjCk/formResponse"
  mapping:
    employer:
      name: "entry.1223479717"
    employee:
      name: "entry.1255459603"
      email: "entry.570498028"
      phone: "entry.229881285"


router.post '/wage_theft/report', (req, res) ->
  form = {}

  for entityKey, entity of req.body
    for fieldKey, field of entity
      debug "#{entityKey} #{fieldKey} #{wageTheftReportInfo.mapping[entityKey][fieldKey]}"
      form[wageTheftReportInfo.mapping[entityKey][fieldKey]] = field

  request.post {url: wageTheftReportInfo.post_url, form: form}, (err, httpResponse, body) ->
    return res.status(400).json({err, httpResponse, body}).end() if err?

    res.status(200).end()

router.use '/employer_size', employer_size_router
router.use '/survey', survey_router

module.exports = router
