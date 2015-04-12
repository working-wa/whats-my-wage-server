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

createGoogleSpreadsheetEndpoint = (config) ->
  (req, res) ->
    form = {}

    for entityKey, entity of req.body
      for fieldKey, field of entity
        form[config.mapping[entityKey][fieldKey]] = field

    columns["Timestamp"] = moment().format("M/D/YYYY HH:mm:ss")

    spreadsheet = Spreadsheet config.spreadsheet

    async.series [
      (done) ->
        result = spreadsheet.add(columns)?.next()

        if !result?
          return done {msg: "Unable to add contact us row"}
        return done null, result
    ], (err, results) ->
      return res.status(400).json(err).end()
      res.status(200).end()

googleApiAuth =
  email: process.env.GOOGLE_ACCOUNT
  key: process.env.GOOGLE_APIS_KEY

wageTheftConfig =
  spreadsheet:
    auth: googleApiAuth
    fileId: process.env.GOOGLE_SPREADSHEET_WAGE_THEFT_FILE_ID
  mapping:
    employer:
      name: "Name of Business"
    employee:
      name: "Name"
      email: "Email"
      phone: "Phone number"
  error_msg: "Unable to add wage theft report"

router.post createGoogleSpreadsheetEndpoint(wageTheftConfig)

contactUsConfig =
  spreadsheet:
    auth: googleApiAuth
    fileId: process.env.GOOGLE_SPREADSHEET_CONTACT_US_FILE_ID
  mapping:
    employer:
      name: "Name of Business"
    employee:
      name: "Name"
      email: "Email"
      phone: "Phone Number"
      comments: "Comments"
  error_msg: "Unable to add contact us report"

router.post '/contact_us', createGoogleSpreadsheetEndpoint contactUsConfig

router.use '/employer_size', employer_size_router
router.use '/survey', survey_router

module.exports = router
