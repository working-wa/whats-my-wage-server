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
      form[wageTheftReportInfo.mapping[entityKey][fieldKey]] = field

  request.post {url: wageTheftReportInfo.post_url, form: form}, (err, httpResponse, body) ->
    if err?
      console.log "Unsuccessfully posted wage theft: #{JSON.stringify req.body}"
      return res.status(400).json({err, httpResponse, body}).end()

    res.status(200).end()

contactUsInfo =
  post_url: "https://docs.google.com/forms/d/1FTlm-_10lrVszCE5eegwGSzpZCWenVwp7b_GfqBITs4/formResponse"
  mapping:
    employer:
      name: "entry.786354004"
    employee:
      name: "entry.2064652974"
      email: "entry.865525263"
      phone: "entry.86958528"
      comments: "entry.37898216"

router.post '/contact_us', (req, res) ->
  form = {}

  for entityKey, entity of req.body
    for fieldKey, field of entity
      form[contactUsInfo.mapping[entityKey][fieldKey]] = field

  request.post {url: contactUsInfo.post_url, form: form}, (err, httpResponse, body) ->
    if err?
      console.log "Unsuccessfully posted contact us: #{JSON.stringify req.body}"
      return res.status(400).json({err, httpResponse, body}).end()

    res.status(200).end()

router.use '/employer_size', employer_size_router
router.use '/survey', survey_router

module.exports = router
