const mongoose = require('mongoose')
const ObjectId = mongoose.Schema.ObjectId

const SyllabusSchema = mongoose.Schema({
  courseId: {
    type: ObjectId,
    ref: 'Course'
  },
  editorId: {
    type: ObjectId,
    ref: 'User'
  },
  formatId: {
    type: ObjectId,
    ref: 'Format'
  },
  programOutcomes: [{
    label: String,
    content: String
  }],
  courseLearningOutcomes: [{
    label: String,
    content: String,
    programOutcomes: [{
      type: String
    }]
  }],
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
