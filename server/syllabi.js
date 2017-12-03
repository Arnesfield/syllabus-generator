const Syllabus = require('../db/syllabus')
const User = require('../db/user')

module.exports = function(app) {
  // single search
  app.post('/syllabus', (req, res) => {
    const courseId = req.body.courseId

    // get latest version
    Syllabus.findOne({ courseId: courseId }, null, {
      sort: { version: -1 }
    }, (err, syllabus) => {
      if (err || !syllabus) {
        if (err) { console.log(err) }
        res.json({ success: false })
        return
      }
      // find user of editorId
      User.findById(syllabus.editorId, (err, user) => {
        res.json({ success: true, syllabus: syllabus, editor: user })
      })
    })
  })
}
