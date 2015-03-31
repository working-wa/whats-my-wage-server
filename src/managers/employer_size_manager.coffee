debug = require('debug')('minimum-wage-service')
models = require '../models'
underscore = require 'underscore'

module.exports = class EmployerSizeManager
  constructor: () ->

  addEmployerSize: (employer, size, reportType,  cb) ->
    onFailure = (err) ->
      cb { err: "Unable to initiate transaction" }

    onSuccessOfStartTransaction = (transaction) =>

      rollbackAndCallback = (err) ->
        #transaction.rollback()
        cb err

      @createOrUpdateEmployer employer, { transaction }, (err, employer) =>
        return rollbackAndCallback(err) if err?

        report =
          EmployerId: employer.id
          size: size
          reportType: reportType

        @createEmployerSizeReport report, { transaction }, (err, report) =>
          return rollbackAndCallback(err) if err?

          @determineEmployerSizeFromReports employer, transaction, (err, determinedSize) =>
            return rollbackAndCallback(err) if err?

            debug "Determined Size: #{determinedSize}"
            employer.size = determinedSize

            onSuccess = (employer) ->
              transaction.commit()
              cb null, employer

            employer.save().then onSuccess, rollbackAndCallback

    models.sequelize.transaction().then onSuccessOfStartTransaction, onFailure

  createOrUpdateEmployer: (employerData, options, cb) ->
    onFailure = (err) ->
      debug "Error on Create/Update Employer: #{JSON.stringify err}"
      cb { err: "Could not update or create employer" }

    onSuccessfulCreationOfEmployer = (storedEmployer, created) ->
      onSuccessfulCreationOfAddress = (storedAddress, created) ->
        onSuccessfulAdditionOfAddress = () ->
          cb null, storedEmployer

        storedEmployer.addAddress(storedAddress, options).then(onSuccessfulAdditionOfAddress, onFailure)

      models.Address.findOrCreate(
        {where: employerData.address}, options
      ).spread(onSuccessfulCreationOfAddress).then(null, onFailure)

    models.Employer.findOrCreate(
      {where: underscore.pick(employerData, "name", "size")}, options
    ).spread(onSuccessfulCreationOfEmployer).then(null, onFailure)

  createEmployerSizeReport: (report, options, cb) ->
    debug "Report: #{JSON.stringify report}"
    onFailure = (err) ->
      cb { err: "Could not create an employee size report" }

    onSuccess = (createdReport) ->
      cb null, createdReport

    models.EmployerSizeReport.create(report, options).then onSuccess, onFailure

  getEmployerSizeByAddress: (address, cb) ->
    onFailure = (err) ->
      cb { err: "Could not get employee size by address" }

    onSuccess = (employer) ->
      cb null, employer?.size

    models.Employer.find({where: address}).then onSuccess, onFailure

  getEmployerSizeByName: (name, cb) ->
    onFailure = (err) ->
      cb { err: "Could not get employee size by name" }

    onSuccess = (employer) ->
      cb null, employer?.size

    models.Employer.find({where: {name: name}}).then onSuccess, onFailure

  determineEmployerSizeFromReports: (employer, transaction, cb) ->
    onFailure = (err) ->
      debug "Failure: #{JSON.stringify err}"
      cb { err: "Could not aggregate employer size" }

    onSuccess = (report) ->
      return cb null, null if not report?
      cb null, report.size

    models.EmployerSizeReport.findOne(
      where:
        EmployerId: employer.id
      order: [["createdAt", "DESC"]]
    ).then onSuccess, onFailure
