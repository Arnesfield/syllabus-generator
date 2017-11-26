const path = require('path')
const express = require('express')
const app = express()

app.set('port', process.env.PORT || 3000)
app.use('/', express.static(path.join(__dirname, '/public/')))
app.all('*', (req, res) => {
  res.redirect('/')
})

app.listen(app.get('port'), () => {
  console.log('Listening on port %d.', app.get('port'))
})
