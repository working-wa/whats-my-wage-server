module.exports = (sequelize, DataTypes) ->
  Address = sequelize.define "Address", {
    id:
      type: DataTypes.UUID
      primaryKey: true
      defaultValue: DataTypes.UUIDV4
    street: DataTypes.STRING
    city:
      type: DataTypes.STRING
      defaultValue: "Seattle",
    state:
      type: DataTypes.STRING
      defaultValue: "Washington",
    zip_code:
      type: DataTypes.STRING
      defaultValue: null,
    latitude:
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: null,
      validate: { min: -90, max: 90 }
    longitude:
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: null,
      validate: { min: -180, max: 180 }
  }
