const production = process.env.NODE_ENV === 'production'
const forceDev = true

export default forceDev || !production ?
  'http://localhost:8080/xforge/public/' :
  'http://codegenerator.x10host.com/'
