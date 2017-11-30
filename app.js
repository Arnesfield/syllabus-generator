const path = require('path')
const express = require('express')
const bodyParser = require('body-parser')
const session = require('express-session')
const db = require('./db')
const app = express()

const maxAge = 2*3600*1000

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(session({
  secret: require('./secret/session'),
  resave: false,
  saveUninitialized: true,
  cookie: {
    secure: false,
    maxAge: maxAge
  }
}))
app.use('/', express.static(path.join(__dirname, '/public/')))
app.set('port', process.env.PORT || 3000)

require('./server/login')(app)
require('./server/checkSession')(app, maxAge)

app.all('*', (req, res) => {
  res.redirect('/#' + req.url)
})

app.listen(app.get('port'), () => {
  console.log('Listening on port %d.', app.get('port'))
})
