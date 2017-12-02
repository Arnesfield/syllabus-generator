const mongoose = require('mongoose')

const UserSchema = mongoose.Schema({
  username: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  type: {
    type: Number,
    required: true
  },
  status: {
    type: Number,
    required: true
  }
}, { collection: 'users' })

module.exports = mongoose.model('User', UserSchema)
