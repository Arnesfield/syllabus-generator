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
        console.log(err)
        res.json({ success: false })
        return
      }

      const hash = user.password
      // compare password
      bcrypt.compare(password, hash, (err, result) => {
        if (result === true) {
          // save user session here
          req.session.userId = user._id
        }

        res.json({ success: result })
      })
    })
  })
}
