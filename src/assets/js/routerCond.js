import storage from './storage'

export default function(router, http) {

  var timeoutSet = false

  const expireTimer = function(endAt) {
    console.error(endAt - Date.now())
    timeoutSet = true
    setTimeout(function() {
      alert('Session expired')
      timeoutSet = false
      storage.destroy()
      router.push('login')
    }, endAt - Date.now())
  }

  // router
  router.beforeEach((to, from, next) => {
    // set title
    const title = to.meta.title || to.name

    // check session, if component to needs authorization
    const cAuth = typeof to.meta.auth === 'undefined' ? true : to.meta.auth
    // if error page
    if (cAuth === null) {
      document.title = title
      next()
      return
    }

    if (timeoutSet) {
      // do not proceed if component need not auth
      if (!cAuth) {
        next(false)
      } else {
        document.title = title
        next()
      }
      return
    }
    
    // if timeoutSet is not set, check if endAt is set
    const endAt = storage.get('endAt')
    if (endAt) {
      // if set, set a expiration timer and set timeoutSet to true
      expireTimer(endAt)
      document.title = title
      next()
      return
    }

    // if component needs no auth, continue
    if (!cAuth) {
      document.title = title
      next()
      return
    }

    // below here if all cAuth = true
    // check for session
    http.post('/checkSession').then(res => {
      const setAt = res.data.setAt
      const endAt = res.data.endAt

      const isSet = setAt || endAt

      // if i need auth but is not set
      if (!isSet) {
        router.push('login')
        return
      }

      storage.set({ setAt: setAt, endAt: endAt })
      expireTimer(endAt)

      // must have id
      document.title = title
      next()
    }).catch(e => {
      next(false)
    })

  })

}
