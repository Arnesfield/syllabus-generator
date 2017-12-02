const mongoose = require('mongoose')
const ObjectId = mongoose.Schema.ObjectId

const SyllabusSchema = mongoose.Schema({
  courseId: {
    type: ObjectId,
    required: true
  },
  editorId: {
    type: ObjectId,
    required: true
  },
  formatId: {
    type: ObjectId,
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
