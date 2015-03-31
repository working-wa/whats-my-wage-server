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

router.post '/wage_theft/report', (req, res) ->
  debug "Req: #{JSON.stringify req.body}"
  res.end()

router.use '/employer_size', employer_size_router
router.use '/survey', survey_router

module.exports = router
