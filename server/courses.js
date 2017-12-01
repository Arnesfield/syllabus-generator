const Course = require('../db/course')

module.exports = function(app) {
  // fetch all course
  app.post('/courses', (req, res) => {
    const search = req.body.search || ''
    const where = {
      '$or': [
        { title: { '$regex': search, $options: 'i' } },
        { code: { '$regex': search, $options: 'i' } }
      ]
    }
    Course.find(where, (err, courses) => {
      if (err) {
        res.json({ courses: [] })
        return
      }
      res.json({ courses: courses })
    })
  })
}
