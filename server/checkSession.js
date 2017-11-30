module.exports = function(app) {
  app.post('/checkSession', (req, res) => {
    const id = req.session.userId || null
    res.json({ id: id })
  })
}
