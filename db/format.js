const mongoose = require('mongoose')
const ObjectId = mongoose.Schema.ObjectId

const FormatSchema = mongoose.Schema({
  editorId: {
    type: ObjectId,
    ref: 'User'
  },
  name: {
    type: String,
    required: true
  },
  format: {
    type: String,
    required: true
  },
  version: {
    type: String,
    required: true
  },
  createdAt: {
    type: Number,
    required: true
  },
  status: {
    type: Number,
    required: true
  }
}, { collection: 'formats' })

module.exports = mongoose.model('Format', FormatSchema)
