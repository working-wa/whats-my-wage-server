# External Dependencies
debug = require('debug')('minimum-wage-service')
express = require 'express'
moment = require 'moment'

# Express Components
router = express.Router()

# Internal Dependencies
{ EmployerSizeManager } = require '../managers'

manager = new EmployerSizeManager()

router.post '/report', (req, res) ->

  #Get Information from Parsed JSON Form Body
  {employer, size, reportType} = req.body

  debug "Size: #{size} Body: #{JSON.stringify req.body}"

  if not employer?
    return res.status(400).json( { err: "`employer` field not provided in json" } )

  #Verify employer size value was passed and is valid
  if not size?
    return res.status(400).json( { err: "`size` field not provided in json" } )

  if size not in ["small","large"]
    return res.status(400).json( { err: "Invalid value provided for `size` field must be either 'small' or 'large'" } )

  #Verify report type value was passed and is valid
  if not reportType?
    return res.status(400).json( { err: "`reportType` field not provided in json" } )

  if reportType? and reportType not in ["employee","employer"]
    return res.status(400).json( { err: "Invalid value provided for `reportType` field must be either 'employee' or 'employer'" } )

  #Call manager to update
  manager.addEmployerSize employer, size, reportType, (err, updatedEmployer) ->
    return res.status(400).json(err).end() if err?

    res.status(200).json({}).end()

router.get '/report', (req, res) ->
  {address, name} = req.query

  debug "Address: #{JSON.stringify address}"

  debug "Name: #{name}"

  if !name?
    return res.status(400).json { err: "Must provide a name param!"}

  returnEmployeesCallback = (err, employerSize) ->

    return res.status(404).end() if !employerSize?

    return res.status(200).json({
      size: employerSize
    }).end()

  manager.getEmployerSizeByName name, returnEmployeesCallback

module.exports = router
