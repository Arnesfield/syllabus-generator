const mongoose = require('mongoose')

const SyllabusSchema = mongoose.Schema({
  username: {
    type: String,
    required: true
  },
  courseId: {
    type: String,
    required: true
  },
  editorId: {
    type: String,
    required: true
  },
  formatId: {
    type: String,
    required: true
  },
  content: {
    type: String,
    required: true
  },
  createdAt: {
    type: Number,
    required: true
  },
  updatedAt: {
    type: Number,
    required: true
  },
  version: {
    type: String,
    required: true
  },
  status: {
    type: Number,
    required: true
  }
}, { collection: 'syllabi' })

module.exports = mongoose.model('Syllabus', SyllabusSchema)
