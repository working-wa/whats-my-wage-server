module.exports = (sequelize, DataTypes) ->
  EmployerSizeReport = sequelize.define "EmployerSizeReport", {
    id:
      type: DataTypes.UUID
      primaryKey: true
      defaultValue: DataTypes.UUIDV4
    size: DataTypes.ENUM("small","large")
    reportType: DataTypes.ENUM("employer","employee")
  }, {
    classMethods : {
      associate: (models) ->

    }
  }

