const mongoose = require('mongoose')

const CourseSchema = mongoose.Schema({
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  code: {
    type: String,
    required: true
  },
  fields: {
    type: Array,
    required: true
  },
  units: {
    type: Number,
    required: true
  },
  status: {
    type: Number,
    required: true
  }
})

module.exports = mongoose.model('Course', CourseSchema)
