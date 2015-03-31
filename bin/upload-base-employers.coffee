csv = require "csv"
fs = require "fs"

{EmployerSizeManager} = require '../src/managers'

manager = new EmployerSizeManager()

fs.readFile "src/data/seattle-employers-starting-size-data.csv", (err, data) ->
  return console.log("Error: #{err}") if err?

  csv.parse data, {columns: true}, (err, output) ->
    return console.log("Error: #{err}") if err?

    for i in output
      
      employer =
        name: i.Name
        address:
          street: i.Address
          city: i.City
          state: i.State
          zip_code: i.Zip

      size = if i["Large or Small"] == "Large"
        "large"
      else if i["Large or Small"] == "Small"
        "small"

      if size?
        manager.addEmployerSize employer, size, "employee", (err) ->
          if err?
            console.log("Unsuccessfully added #{employer.name}")
            console.log("Error: #{JSON.stringify err}")



