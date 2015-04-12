# External Dependencies
async = require 'async'
debug = require('debug')('minimum-wage-service')
express = require 'express'
request = require 'request'
Spreadsheet = require 'google-spreadsheet-append'

# Express Components
router = express.Router()


#Internal Dependencies
employer_size_router = require './employer_size'
survey_router = require './survey'

router.all '*', (req,res,next) ->
  res.header("Access-Control-Allow-Origin", "*")
  res.header("Access-Control-Allow-Headers", "Content-Type, X-Requested-With")
  next()

googleApiAuth =
  email: process.env.GOOGLE_ACCOUNT
  key: process.env.GOOGLE_APIS_KEY

wageTheftSpreadsheetConfig =
  auth: googleApiAuth
  fileId: process.env.GOOGLE_SPREADSHEET_WAGE_THEFT_FILE_ID

wageTheftReportInfo =
  post_url: "https://docs.google.com/forms/d/12rKqdkVtQTcckc3ZyNp6AY7sZIKlj11k-QVFaAwKjCk/formResponse"
  mapping:
    employer:
      name: "Name of Business"
    employee:
      name: "Name"
      email: "Email"
      phone: "Phone number"

router.post '/wage_theft/report', (req, res) ->
  form = {}

  for entityKey, entity of req.body
    for fieldKey, field of entity
      columns[wageTheftReportInfo.mapping[entityKey][fieldKey]] = field

  columns["Timestamp"] = moment().format("M/D/YYYY HH:mm:ss")

  spreadsheet = Spreadsheet wageTheftSpreadsheetConfig

  async.series [
    (done) ->
      result = spreadsheet.add(columns)?.next()

      if !result?
        return done {msg: "Unable to add wage theft report"}
      return done null, result
  ], (err, results) ->
    return res.status(400).json(err).end()
    res.status(200).end()

  request.post {url: wageTheftReportInfo.post_url, form: form}, (err, httpResponse, body) ->
    if err?
      console.log "Unsuccessfully posted wage theft: #{JSON.stringify req.body}"
      return res.status(400).json({err, httpResponse, body}).end()

    res.status(200).end()

contactUsSpreadsheetConfig =
  auth: googleApiAuth
  fileId: process.env.GOOGLE_SPREADSHEET_CONTACT_US_FILE_ID

contactUsInfo =
  post_url: "https://docs.google.com/forms/d/1FTlm-_10lrVszCE5eegwGSzpZCWenVwp7b_GfqBITs4/formResponse"
  mapping:
    employer:
      name: "Name of Business"
    employee:
      name: "Name"
      email: "Email"
      phone: "Phone Number"
      comments: "Comments"

router.post '/contact_us', (req, res) ->
  form = {}

  for entityKey, entity of req.body
    for fieldKey, field of entity
      form[contactUsInfo.mapping[entityKey][fieldKey]] = field

  columns["Timestamp"] = moment().format("M/D/YYYY HH:mm:ss")

  spreadsheet = Spreadsheet contactUsSpreadsheetConfig

  async.series [
    (done) ->
      result = spreadsheet.add(columns)?.next()

      if !result?
        return done {msg: "Unable to add contact us row"}
      return done null, result
  ], (err, results) ->
    return res.status(400).json(err).end()
    res.status(200).end()

router.use '/employer_size', employer_size_router
router.use '/survey', survey_router

module.exports = router
