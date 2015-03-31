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
    post_url: "https://docs.google.com/forms/d/1ArpKfNDrrsdNl05VLkT3tECjA0vctk8wnVrMGQSIqIE/formResponse"
    mapping:
      "employer-name": "entry.1223479717"
      "employee-name": "entry.1255459603"
      "employee-email": "entry.570498028"
      "employee-phone": "entry.229881285"
  }).end()

router.use '/employer_size', employer_size_router
router.use '/survey', survey_router

module.exports = router
