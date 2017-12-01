module.exports = function(app) {
  app.post('/logout', (req, res) => {
    delete req.session
    res.json({ success: true })
  })
}
