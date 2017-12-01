module.exports = function(app) {
  app.post('/logout', (req, res) => {
    req.session.destroy()
    res.json({ success: true })
  })
}
