const path = require('path')
const express = require('express')
const bodyParser = require('body-parser')
const bcrypt = require('bcrypt')
const app = express()

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

// login
app.post('/login', (req, res) => {
  const username = req.body.username
  const password = req.body.password

  // test hash
  const hash = "$2a$10$VKVumbYqH92HhvsXtY2CU.IANs9LBFqB6lF5iLK0eXhjdoSWJEq1m"

  // compare password
  bcrypt.compare(password, hash, (err, result) => {
    res.json({ success: result })
  })
})

app.set('port', process.env.PORT || 3000)
app.use('/', express.static(path.join(__dirname, '/public/')))
app.all('*', (req, res) => {
  res.redirect('/')
})

app.listen(app.get('port'), () => {
  console.log('Listening on port %d.', app.get('port'))
})
