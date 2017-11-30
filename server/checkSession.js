module.exports = function(app, maxAge) {
  app.post('/checkSession', (req, res) => {
    const setAt = req.session.setAt || null
    if (setAt) {
      res.json({ setAt: setAt, endAt: setAt + maxAge + 10000 })
    } else {
      res.json({})
    }
  })
}
