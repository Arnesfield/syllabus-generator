const path = require('path')
const express = require('express')
const bodyParser = require('body-parser')
const db = require('./db')
const app = express()

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use('/', express.static(path.join(__dirname, '/public/')))
app.set('port', process.env.PORT || 3000)

require('./server/login')(app)

app.all('*', (req, res) => {
  res.redirect('/#' + req.url)
})

app.listen(app.get('port'), () => {
  console.log('Listening on port %d.', app.get('port'))
})
