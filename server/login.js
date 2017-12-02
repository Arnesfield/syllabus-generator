const bcrypt = require('bcrypt')
const User = require('../db/user')

module.exports = function(app) {
  // login
  app.post('/login', (req, res) => {
    const username = req.body.username
    const password = req.body.password

    // fetch hashed password from db instead
    User.findOne({ username: username }, (err, user) => {
      if (err || !user) {
        if (err) { console.log(err) }
        res.json({ success: false, msg: 'Invalid username or password.' })
        return
      }

      const hash = user.password
      // compare password
      bcrypt.compare(password, hash, (err, result) => {
        var json = { success: result }

        if (result === true && user.status !== 1) {
          json.success = false
          json.msg = 'This account has been suspended.'
        } else if (result === true) {
          // save user session here
          req.session.userId = user._id
          req.session.userType = user.type
          req.session.setAt = Date.now()
        } else {
          json.msg = 'Invalid username or password.'
        }

        res.json(json)
      })
    })
  })
}
