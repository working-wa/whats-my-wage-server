module.exports = (sequelize, DataTypes) ->
  Employer = sequelize.define "Employer", {
    id:
      type: DataTypes.UUID
      primaryKey: true
      defaultValue: DataTypes.UUIDV4
    name: DataTypes.STRING,
    size:
      type: DataTypes.ENUM("small","large")
      allowNull: true
  }, classMethods : {
    associate: (models) ->
      Employer.hasMany(models.EmployerSizeReport)
      Employer.hasMany(models.Address)
  }
