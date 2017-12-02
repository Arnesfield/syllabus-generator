const Syllabus = require('../db/syllabus')

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

      res.json({ success: true, syllabus: syllabus })
    })
  })
}
