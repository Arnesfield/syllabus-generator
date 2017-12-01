const Book = require('../db/book')

module.exports = function(app) {
  // fetch all books
  app.post('/books', (req, res) => {
    Book.find((err, books) => {
      if (err) {
        res.json({ books: [] })
        return
      }
      res.json({ books: books })
    })
  })
}
