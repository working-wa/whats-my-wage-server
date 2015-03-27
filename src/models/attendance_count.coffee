module.exports = (sequelize, DataTypes) ->
  AttendanceCount = sequelize.define "AttendanceCount", {
    time: DataTypes.DATE
    attendance: DataTypes.INTEGER
  }

  return AttendanceCount
