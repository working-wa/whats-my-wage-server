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

wageTheftReportInfo =
  post_url: "https://docs.google.com/forms/d/12rKqdkVtQTcckc3ZyNp6AY7sZIKlj11k-QVFaAwKjCk/formResponse"
  mapping:
    "employer[name]": "entry.1223479717"
    "employee[name]": "entry.1255459603"
    "employee[email]": "entry.570498028"
    "employee[phone]": "entry.229881285"

router.post '/wage_theft/report', (req, res) ->
  form = {}

  for k,v of req.body
    form[wageTheftReportInfo.mapping[k]] = v

  request.post {url: wageTheftReportInfo, form: form}, (err, httpResponse, body) ->
    return res.status(400).end() if err?

    res.status(200).end()

router.use '/employer_size', employer_size_router
router.use '/survey', survey_router

module.exports = router
