const mongoose = require('mongoose')

const BookSchema = mongoose.Schema({
  citation: {
    type: String,
    required: true
  },
  fields: {
    type: Array,
    required: true
  },
  status: {
    type: Number,
    required: true
  }
}, { collection: 'books' })

module.exports = mongoose.model('Book', BookSchema)
