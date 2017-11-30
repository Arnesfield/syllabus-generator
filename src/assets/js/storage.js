const KEY = 'vue-sess-key'

// manipulate localStorage
const storage = {
  get: function(key) {
    const strData = window.localStorage.getItem(KEY)
    const data = JSON.parse(strData) || {}
    return typeof key !== 'string' ? data : data[key]
  },

  set: function(data, overwrite) {
    // check if data is valid
    if (!data || data.constructor === Array) {
      return false
    }

    // get all
    var get = this.get()
    var obj = overwrite ? data : Object.assign(get, data)
    const jsonStr = JSON.stringify(obj)

    window.localStorage.setItem(KEY, jsonStr)
    return true
  },

  delete: function(key) {
    var get = this.get()
    if (get[key] == null) {
      return false
    }
    delete get[key]
    return this.set(get, true)
  },

  destroy: function() {
    window.localStorage.removeItem(KEY)
    return true
  }
}

export default storage
