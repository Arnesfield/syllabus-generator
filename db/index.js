const mongoose = require('mongoose')

mongoose.connect('mongodb://localhost/forge', { useMongoClient: true })
const db = mongoose.connection

// check connection
db.once('open', () => {
  console.log('Connected to MongoDB.')
})

// check for db errors
db.on('error', (err) => {
  console.log(err)
})

module.exports = db
