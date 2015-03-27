# External Dependencies
chai = require 'chai'
chaiHttp = require 'chai-http'
mocha = require 'mocha'
moment = require 'moment'

# Internal Dependencies
app = require '../../src/app'
models = require '../../src/models'

# Test Setup
chai.use chaiHttp

describe 'Get Employer Size For Employer', () ->
  describe 'Receiving valid request with valid name', () ->
    beforeEach (done) ->
      models.sequelize.drop().then () ->
        models.sequelize.sync().then () ->
          done()

    afterEach (done) ->
      models.sequelize.drop().then () ->
        models.sequelize.sync().then () ->
          done()

    describe 'and a Single Data Points Exists For the Employer', () ->
      beforeEach (done) ->
        models.Employer.bulkCreate([
          { name: "McDonalds", size: "large" },
          { name: "Kaladi Brothers", size: "small" }
        ]).then () -> done()
      it 'should return a correct size of business', (done) ->
        #TODO: Get chai-http query parameter feature to work
        chai.request(app)
          .get('/v1/employer_size/report?name=McDonalds')
          .send()
          .end (err, res) ->
            chai.expect(err).to.be.null
            chai.expect(res).to.have.status(200)
            chai.expect(res).to.be.json
            chai.expect(res.body).to.deep.equal
              "size":"large"
            done()

    describe 'No Data Exists For the Employer', () ->
      beforeEach (done) ->
        models.Employer.bulkCreate([
          { name: "McDonalds", size: "large" },
          { name: "Kaladi Brothers", size: "small" }
        ]).then () -> done()
      it 'should return a 404', (done) ->
        chai.request(app)
          .get('/v1/employer_size/report?name=Starbucks')
          .send()
          .end (err, res) ->
            chai.expect(err).to.be.null
            chai.expect(res).to.have.status(404)
            done()

  it 'should return a 400 when there is a missing name param', (done) ->
    chai.request(app)
      .get('/v1/employer_size/report')
      .send()
      .end (err, res) ->
        chai.expect(err).to.be.null
        chai.expect(res).to.have.status(400)
        done()
