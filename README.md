# Minimum Wage Server Documentation

## Setup

* Install dependencies - `npm install`
* Run Server - `npm start`

## Project Layout

* config/ - Directory containing configuration file
  * default.json - Default configuration
  * test.json - Test configuration
  * *Default Configuration is used unless `NODE_ENV` environment variable is specified then it using the file prefixed here accordingly.*
* src/ - Source code for the service
  * app.coffee - Main application file for Express application
  * managers/ - Modules for querying the database and other operations
  * routes/ - Has the incoming http route implementations which do input checking and then call the manager
  * models/ - Contains the database model for the application
* test/ - Test files for the service
  * integration/ - Integrations test for the service

## Endpoints Offered

### `POST` "/v1/employer_size/report" - To set attendance count for a single minute

#### Example Input

{
  "employer":{ "name":"Starbucks", "address": {"street":"100 Union Street"}},
  "size":"small",
}

#### Example Output

No Output

### `GET` "/v1/employer_size/report" - Get the latest employer size report received

#### Example Input

*Query String*: name=[employer name]&address=[address]

## Testing

* Run `npm test`
* Currently using mocha as the test runner and chai-http to run integration tests against the service

