const mongoose = require('mongoose')

const BookSchema = mongoose.Schema({
  citation: {
    type: String,
    required: true
  },
  fields: [{
    type: String
  }],
  status: {
    type: Number,
    required: true
  }
}, { collection: 'books' })

module.exports = mongoose.model('Book', BookSchema)
