# External Dependencies
chai = require 'chai'
chaiHttp = require 'chai-http'
mocha = require 'mocha'

# Internal Dependencies
app = require '../../src/app'
models = require '../../src/models'

# Test Setup
chai.use chaiHttp

describe 'Posting Employer Size', (done) ->
  beforeEach (done) ->
    models.sequelize.drop().then () ->
      models.sequelize.sync().then () ->
        done()

  afterEach (done) ->
    models.sequelize.drop().then () ->
      models.sequelize.sync().then () ->
        done()

  it 'should accept a valid request', (done) ->
    chai.request(app)
      .post('/v1/attendance')
      .send({
        "time": "2014-10-31T10:43Z",
        "attendance": 432
      })
      .end (err, res) ->
        chai.expect(err).to.be.null
        chai.expect(res).to.have.status(200)
        done()

  it 'should return a 400 when no body provided', (done) ->
    chai.request(app)
      .post('/v1/attendance')
      .send()
      .end (err, res) ->
        chai.expect(err).to.be.null
        chai.expect(res).to.have.status(400)
        done()

  it 'should return a 400 when an invalid date is provided', (done) ->
    chai.request(app)
      .post('/v1/attendance')
      .send({
        "time": "2014-10-31T10:Z",
        "attendance": 432
      })
      .end (err, res) ->
        chai.expect(err).to.be.null
        chai.expect(res).to.have.status(400)
        done()

  it 'should return a 400 when no time is provided', (done) ->
    chai.request(app)
      .post('/v1/attendance')
      .send({
        "attendance": 432
      })
      .end (err, res) ->
        chai.expect(err).to.be.null
        chai.expect(res).to.have.status(400)
        done()

  it 'should return a 400 when no attendance number is provided', (done) ->
    chai.request(app)
      .post('/v1/attendance')
      .send({
        "time": "2014-10-31T10:43Z",
      })
      .end (err, res) ->
        chai.expect(err).to.be.null
        chai.expect(res).to.have.status(400)
        done()

  it 'should return a 400 when a negative attendance number is provided', (done) ->
    chai.request(app)
      .post('/v1/attendance')
      .send({
        "time": "2014-10-31T10:43Z",
        "attendance": -5
      })
      .end (err, res) ->
        chai.expect(err).to.be.null
        chai.expect(res).to.have.status(400)
        done()
